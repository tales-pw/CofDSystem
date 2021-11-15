package pw.tales.cofdsystem.character.traits.advantages.health.events;

import pw.tales.cofdsystem.game_object.events.GameObjectEvent;
import pw.tales.cofdsystem.damage.Damage;
import pw.tales.cofdsystem.game_object.GameObject;

@:expose("GameObjectDamagedEvent")
class GameObjectDamagedEvent extends GameObjectEvent
{
    private final damage:Damage;

    public function new(gameObject:GameObject, damage:Damage)
    {
        super(gameObject);
        this.damage = damage;
    }

    public function getDamage():Damage
    {
        return this.damage;
    }
}
