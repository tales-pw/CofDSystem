package pw.tales.cofdsystem.mocks;

import pw.tales.cofdsystem.action.Action;
import pw.tales.cofdsystem.action.EnumTime;
import pw.tales.cofdsystem.action.opposition.base.Opposition;

class BasicAction extends Action
{
    public function new(opposition:Opposition, time:EnumTime, system:CofDSystem)
    {
        super(opposition, time, system);
    }
}
