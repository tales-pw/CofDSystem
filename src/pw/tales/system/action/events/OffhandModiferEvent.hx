package pw.tales.system.action.events;

import pw.tales.system.game_object.events.IGameObjectEvent;
import pw.tales.system.game_object.GameObject;

class OffhandModiferEvent implements IGameObjectEvent {
    public final gameObject:GameObject;
    public var modifer:Int = -2;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function getModifer():Int {
        return this.modifer;
    }

    public function setModifer(modifer:Int) {
        this.modifer = modifer;
    }

    public function isRelated(gameObject:GameObject) {
        return this.gameObject == gameObject;
    }
}
