package pw.tales.system.action.opposition.base;

import pw.tales.system.action.opposition.pool.ActionPool;
import pw.tales.system.game_object.GameObject;
import thx.error.AbstractMethod;

class OppositionCompetitive extends Opposition {
    private var targetPool:ActionPool;

    public function new(actorRoll:ActionPool, targetPool:ActionPool) {
        super(actorRoll);
        this.targetPool = targetPool;
    }

    override public function getPool(gameObject:GameObject):ActionPool {
        if (targetPool.getGameObject() == gameObject) return targetPool;
        return super.getPool(gameObject);
    }

    public function getTargetPool():ActionPool {
        return this.targetPool;
    }

    override public function isRelated(character:GameObject):Bool {
        return super.isRelated(character) || this.targetPool.getGameObject() == character;
    }

    public function getWinnerPool():ActionPool throw new AbstractMethod();
}
