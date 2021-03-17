package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.weapon.traits.weapon_tags.events.WeaponTagsCollectEvent;

class WeaponTag extends WeaponTrait {
    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>) {
        super(dn, gameObject, type);
        this.eventBus.addHandler(WeaponTagsCollectEvent, (e:WeaponTagsCollectEvent) -> e.collect(this));
    }
}
