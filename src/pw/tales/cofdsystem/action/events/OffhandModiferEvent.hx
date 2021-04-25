package pw.tales.cofdsystem.action.events;

import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

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
