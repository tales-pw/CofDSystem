package pw.tales.system.action.events.pool;

import pw.tales.system.action.opposition.pool.ActionPool;
import pw.tales.system.game_object.GameObject;

class ActionPoolEvent extends ActionEvent {
    private var pool:ActionPool;

    public function new(action:IAction, pool:ActionPool) {
        super(action);
        this.pool = pool;
    }

    public function getActionPool():ActionPool {
        return this.pool;
    }

    public function isPoolOwner(gameObject:GameObject):Bool {
        return pool.getGameObject() == gameObject;
    }

    public function isActorPool():Bool {
        return this.pool == this.getAction().getOpposition().getActorPool();
    }
}
