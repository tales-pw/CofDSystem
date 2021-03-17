package pw.tales.system.mocks;

import pw.tales.system.action.Action;
import pw.tales.system.action.EnumTime;
import pw.tales.system.action.opposition.base.Opposition;

class BasicAction extends Action {
    public function new(opposition:Opposition, time:EnumTime) {
        super(opposition, time);
    }
}
