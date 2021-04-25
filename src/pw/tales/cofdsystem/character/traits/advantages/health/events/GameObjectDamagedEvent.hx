package pw.tales.cofdsystem.character.traits.advantages.health.events;

import pw.tales.cofdsystem.damage.Damage;
import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

class GameObjectDamagedEvent implements IGameObjectEvent {
    private final gameObject:GameObject;
    private final damage:Damage;

    public function new(gameObject:GameObject, damage:Damage) {
        this.gameObject = gameObject;
        this.damage = damage;
    }

    public function getDamage():Damage {
        return this.damage;
    }

    public function getGameObject():GameObject {
        return this.gameObject;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return gameObject == this.gameObject;
    }
}
