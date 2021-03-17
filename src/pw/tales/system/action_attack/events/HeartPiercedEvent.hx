package pw.tales.system.action_attack.events;

import pw.tales.system.game_object.events.IGameObjectEvent;
import pw.tales.system.game_object.GameObject;

class HeartPiercedEvent implements IGameObjectEvent {
    private final gameObject:GameObject;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return this.gameObject == gameObject;
    }
}
