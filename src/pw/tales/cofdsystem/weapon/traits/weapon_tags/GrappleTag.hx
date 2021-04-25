package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   Grapple weapon tag.
 *
 *   @see <https://tales.pw/page/grapple_(weapon_tag)>
**/
@RegisterTraitTypes
class GrappleTag extends WeaponTag {
    public static final DN = "grapple_(weapon_tag)";
    public static final TYPE:TraitType<GrappleTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<GrappleTag>):GrappleTag {
        return new GrappleTag(gameObject);
    }
}
