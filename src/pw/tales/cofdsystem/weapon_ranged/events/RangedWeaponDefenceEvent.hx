package pw.tales.cofdsystem.weapon_ranged.events;

import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

class RangedWeaponDefenceEvent implements IGameObjectEvent {
    private final gameObject:GameObject;
    private var canApply:Bool = false;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function getGameObject():GameObject {
        return this.gameObject;
    }

    public function getCanApply():Bool {
        return this.canApply;
    }

    public function setCanApply(canApply:Bool):Void {
        this.canApply = canApply;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return gameObject == this.gameObject;
    }
}
