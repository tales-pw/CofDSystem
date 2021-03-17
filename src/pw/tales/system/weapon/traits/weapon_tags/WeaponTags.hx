package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.weapon.traits.weapon_tags.events.WeaponTagsCollectEvent;

@:keep
@:expose("WeaponTags")
class WeaponTags {
    public static function collect(gameObject:GameObject):Array<WeaponTag> {
        var event = new WeaponTagsCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
