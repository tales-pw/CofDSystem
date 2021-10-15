package pw.tales.cofdsystem.action.competition;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.action.pool.ActionPool;

class Competition implements IActionRoll
{
    private final actorPool:ActionPool;
    private final targetPool:ActionPool;

    public function new(actorPool:ActionPool, targetPool:ActionPool)
    {
        this.actorPool = actorPool;
        this.targetPool = targetPool;
    }

    public function willRoll(roll:ActionPool):Bool
    {
        throw new haxe.exceptions.NotImplementedException();
    }

    public function getWinnerPool():ActionPool
    {
        throw new haxe.exceptions.NotImplementedException();
    }

    public function isRelated(gameObject:GameObject):Bool
    {
        return this.actorPool.isRelated(gameObject) || this.targetPool.isRelated(gameObject);
    }

    public function getActorPool():ActionPool
    {
        return this.actorPool;
    }

    public function getTargetPool():ActionPool
    {
        return this.targetPool;
    }

    public function getActor():GameObject
    {
        return this.actorPool.getGameObject();
    }

    public function getTarget():GameObject
    {
        return this.targetPool.getGameObject();
    }

    public function getPool(gameObject:GameObject):ActionPool
    {
        if (this.actorPool.isRelated(gameObject))
        {
            return this.actorPool;
        }

        if (this.targetPool.isRelated(gameObject))
        {
            return this.targetPool;
        }

        throw "${gameObject} is not part of action.";
    }

    public function roll(action:RollAction):Void {}
}
