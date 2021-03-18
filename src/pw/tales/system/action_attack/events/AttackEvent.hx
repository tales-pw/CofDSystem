package pw.tales.system.action_attack.events;

import pw.tales.system.action.events.ActionEvent;
import pw.tales.system.game_object.GameObject;

class AttackEvent extends ActionEvent {
    private final attackAction:AttackAction;

    public function new(action:AttackAction) {
        super(action);
        this.attackAction = action;
    }

    public function getAttackAction():AttackAction {
        return this.attackAction;
    }

    public override function getAction():AttackAction {
        return this.attackAction;
    }

    public function isTarget(gameObject:GameObject) {
        return attackAction.getOpposition().getTargetPool().getGameObject() == gameObject;
    }
}
