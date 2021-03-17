package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

/**
 *   Stun weapon tag.
 *
 *   @see <https://tales.pw/page/stun_(weapon_tag)>
**/
class StunTag extends WeaponTag {
    public static final DN = "stun_(weapon_tag)";
    public static final TYPE:TraitType<StunTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<StunTag>):StunTag {
        return new StunTag(gameObject);
    }
}
