package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.events.WeaponTagsCollectEvent;

@:expose("WeaponTag")
class WeaponTag extends WeaponTrait
{
    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);
        this.eventBus.addHandler(WeaponTagsCollectEvent, (e) -> e.collect(this));
    }
}
