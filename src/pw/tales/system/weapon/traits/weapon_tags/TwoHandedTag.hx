package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

/**
 *   Two-handed weapon tag.
 *
 *   @see <https://tales.pw/page/two-handed_(weapon_tag)>
**/
class TwoHandedTag extends WeaponTag {
    public static final DN = "two-handed_(weapon_tag)";
    public static final TYPE:TraitType<TwoHandedTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<TwoHandedTag>):TwoHandedTag {
        return new TwoHandedTag(gameObject);
    }
}