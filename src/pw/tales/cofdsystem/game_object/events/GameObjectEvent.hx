package pw.tales.cofdsystem.game_object.events;

import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

class GameObjectEvent implements IGameObjectEvent {
    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function getGameObject():GameObject {
        return this.gameObject;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return this.gameObject == gameObject;
    }
}
