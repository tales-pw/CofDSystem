package pw.tales.system.action_attack.modifications;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action.IAction;
import pw.tales.system.action.IModification;
import pw.tales.system.action_attack.events.AttackDamageDealtEvent;
import pw.tales.system.action_attack.events.AttackDamageEvent;
import pw.tales.system.action_attack.targets.ITarget;
import pw.tales.system.utils.events.HandlerPriority;

class SpecifiedTarget implements IModification {
    public static final DN = "specified_attack";

    private final target:ITarget;

    public function new(target:ITarget) {
        this.target = target;
    }

    public function init(action:IAction) {
        var eventBus = action.getEventBus();
        eventBus.addHandler(ActionBuildPoolEvent, this.applyPenalty, HandlerPriority.NORMAL);
        eventBus.addHandler(AttackDamageDealtEvent, this.applyEffect, HandlerPriority.NORMAL);
    }

    public function applyPenalty(event:ActionBuildPoolEvent):Void {
        var opposition = event.getAction().getOpposition();
        var roll = opposition.getActorPool();
        roll.getRequest().addModifier(this.target.getAttackModifer(), DN);
    }

    public function applyEffect(event:AttackDamageEvent) {
        this.target.apply(event.getAction());
    }
}