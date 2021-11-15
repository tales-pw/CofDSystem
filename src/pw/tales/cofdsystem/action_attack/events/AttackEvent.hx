package pw.tales.cofdsystem.action_attack.events;

import pw.tales.cofdsystem.action.events.ActionEvent;
import pw.tales.cofdsystem.game_object.GameObject;

@:expose("AttackEvent")
class AttackEvent extends ActionEvent
{
    private final attackAction:AttackAction;

    public function new(action:AttackAction)
    {
        super(action);
        this.attackAction = action;
    }

    public function getAttackAction():AttackAction
    {
        return this.attackAction;
    }

    public override function getAction():AttackAction
    {
        return this.attackAction;
    }

    public function isTarget(gameObject:GameObject):Bool
    {
        return attackAction.getCompetition().getTarget() == gameObject;
    }
}
