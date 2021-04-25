package pw.tales.cofdsystem.action.opposition.base;

import pw.tales.cofdsystem.action.IAction;
import pw.tales.cofdsystem.action.opposition.pool.ActionPool;
import pw.tales.cofdsystem.game_object.GameObject;
import thx.error.AbstractMethod;

class Opposition {
    private var actorPool:ActionPool;

    private function new(actorPool:ActionPool) {
        this.actorPool = actorPool;
    }

    public function getPool(gameObject:GameObject):ActionPool {
        return actorPool;
    }

    public function willRoll(pool:ActionPool) {
        return actorPool == pool;
    }

    public function getActorPool():ActionPool {
        return this.actorPool;
    }

    public function isRelated(character:GameObject):Bool {
        return this.actorPool.getGameObject() == character;
    }

    public function roll(action:IAction):Void throw new AbstractMethod();
}
