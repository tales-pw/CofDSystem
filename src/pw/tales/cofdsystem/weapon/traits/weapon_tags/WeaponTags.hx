package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.events.WeaponTagsCollectEvent;

@:expose("WeaponTags")
class WeaponTags
{
    public static function collect(gameObject:GameObject):Array<WeaponTag>
    {
        var event = new WeaponTagsCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
