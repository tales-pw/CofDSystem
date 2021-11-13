package pw.tales.cofdsystem.action;

import pw.tales.cofdsystem.game_object.GameObject;

@:expose("NoRollAction")
class NoRollAction extends Action
{
    private final actor:GameObject;

    private function new(actor:GameObject, time:EnumTime, system:CofDSystem)
    {
        super(time, system);
        this.actor = actor;
    }

    public override function getActor():GameObject
    {
        return this.actor;
    }

    public override function isRelated(gameObject:GameObject):Bool
    {
        return this.actor == gameObject;
    }
}
