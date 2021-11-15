package pw.tales.cofdsystem.action.events.roll;

import pw.tales.cofdsystem.action.pool.ActionPool;

@:expose("ActionRollEvent")
class ActionRollEvent extends RollActionEvent
{
    private var roll:ActionPool;

    public function new(action:RollAction, roll:ActionPool)
    {
        super(action);
        this.roll = roll;
    }

    public function getRoll():ActionPool
    {
        return this.roll;
    }
}
