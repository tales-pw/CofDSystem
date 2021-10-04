package pw.tales.cofdsystem.mocks;

import pw.tales.cofdsystem.action.IActionRoll;
import pw.tales.cofdsystem.action.Action;
import pw.tales.cofdsystem.action.EnumTime;

class BasicAction extends Action
{
    public function new(actionRoll:IActionRoll, time:EnumTime, system:CofDSystem)
    {
        super(actionRoll, time, system);
    }
}
