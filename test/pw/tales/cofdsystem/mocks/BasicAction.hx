package pw.tales.cofdsystem.mocks;

import pw.tales.cofdsystem.action.RollAction;
import pw.tales.cofdsystem.action.IActionRoll;
import pw.tales.cofdsystem.action.EnumTime;

class BasicAction extends RollAction
{
    public function new(
        actionRoll:IActionRoll,
        time:EnumTime,
        system:CofDSystem
    )
    {
        super(actionRoll, time, system);
    }
}
