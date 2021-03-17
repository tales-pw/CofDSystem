package pw.tales.system.character.traits.advantages.health.events;

import pw.tales.system.game_object.events.IGameObjectEvent;
import pw.tales.system.game_object.GameObject;

class GameObjectDiedEvent implements IGameObjectEvent {
    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function getGameObject():GameObject {
        return this.gameObject;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return gameObject == this.gameObject;
    }
}
