package pw.tales.cofdsystem.action;

class RollAction extends Action
{
    private final actionRoll:IActionRoll;

    private function new(actionRoll:IActionRoll, time:EnumTime, system:CofDSystem)
    {
        super(time, system);
        this.actionRoll = actionRoll;
    }

    public function getActionRoll():IActionRoll
    {
        return this.actionRoll;
    }

    private function roll():Void
    {
        this.actionRoll.roll(this);
    }

    public override final function execute():Void
    {
        this.beforeAction();
        this.roll();
        this.perform();
        this.afterAction();
    }
}
