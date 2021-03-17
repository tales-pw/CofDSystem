package pw.tales.system.action_attack.modifications;

import pw.tales.system.action.IAction;
import pw.tales.system.action.IModification;
import pw.tales.system.action_attack.targets.ITarget;
import pw.tales.system.dices.EnumResult;
import pw.tales.system.utils.Utility;

class SpecifiedTarget implements IModification {
    public static final DN = "specified_attack";

    private final target:ITarget;

    public function new(target:ITarget) {
        this.target = target;
    }

    public function before(action:IAction):Void {
        var opposition = action.getOpposition();
        var roll = opposition.getActorPool();
        roll.getRequest().addModifier(this.target.getAttackModifer(), DN);
    }

    public function after(action:IAction) {
        var attackAction = Utility.downcast(action, AttackAction);
        if (attackAction == null) return;

        var opposition = action.getOpposition();
        var result = opposition.getActorPool().getResponse().getResult();
        if (EnumResult.isSuccess(result)) this.target.apply(attackAction);
    }
}