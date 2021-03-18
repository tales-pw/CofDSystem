package pw.tales.system.action.events.roll;

import pw.tales.system.action.opposition.pool.ActionPool;

class ActionRollEvent extends ActionEvent {
    private var roll:ActionPool;

    public function new(action:IAction, roll:ActionPool) {
        super(action);
        this.roll = roll;
    }

    public function getRoll():ActionPool {
        return this.roll;
    }
}
