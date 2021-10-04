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

    public function roll(action:IAction):Void {}

    public function willRoll(roll:ActionPool):Bool
    {
        throw new haxe.exceptions.NotImplementedException();
    }

    public function isRelated(gameObject:GameObject):Bool
    {
        return this.actorPool.isRelated(gameObject) || this.targetPool.isRelated(gameObject);
    }
}
