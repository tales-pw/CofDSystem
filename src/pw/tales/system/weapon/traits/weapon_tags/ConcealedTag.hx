package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

/**
 *   Concealed weapon tag.
 *
 *   @see <https://tales.pw/page/concealed_(weapon_tag)>
**/
class ConcealedTag extends WeaponTag {
    public static final DN = "concealed_(weapon_tag)";
    public static final TYPE:TraitType<ConcealedTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<ConcealedTag>):ConcealedTag {
        return new ConcealedTag(gameObject);
    }
}