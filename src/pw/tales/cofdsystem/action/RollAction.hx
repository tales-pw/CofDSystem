package pw.tales.cofdsystem.action;

import pw.tales.cofdsystem.game_object.GameObject;

class RollAction extends Action
{
    private final actionRoll:IActionRoll;

    private function new(actionRoll:IActionRoll, time:EnumTime, system:CofDSystem)
    {
        super(time, system);
        this.actionRoll = actionRoll;
    }

    public override function getActor():GameObject
    {
        return this.actionRoll.getActor();
    }

    public function getActionRoll():IActionRoll
    {
        return this.actionRoll;
    }

    public override function isRelated(gameObject:GameObject):Bool
    {
        return this.actionRoll.isRelated(gameObject);
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
