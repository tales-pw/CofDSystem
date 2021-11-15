package pw.tales.cofdsystem.action.events.pool;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.action.pool.ActionPool;

@:expose("ActionPoolEvent")
class ActionPoolEvent extends RollActionEvent
{
    private var pool:ActionPool;

    public function new(action:RollAction, pool:ActionPool)
    {
        super(action);
        this.pool = pool;
    }

    public function getActionPool():ActionPool
    {
        return this.pool;
    }

    public function isPoolOwner(gameObject:GameObject):Bool
    {
        return pool.getGameObject() == gameObject;
    }

    public function isActorPool():Bool
    {
        return this.pool == this.rollAction.getActionRoll().getActorPool();
    }
}
