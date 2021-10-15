package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   9-Again weapon tag.
 *
 *   @see <https://tales.pw/page/9-again_(weapon_tag)>
**/
@RegisterTraitTypes
class NineAgainTag extends ExplodeTag
{
    public static final DN = "9-again_(weapon_tag)";
    public static final TYPE:TraitType<NineAgainTag> = cast TraitType.createType(DN, create);

    public override function getExplode():EnumExplode
    {
        return EnumExplode.NINE_AGAIN;
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<NineAgainTag>):NineAgainTag
    {
        return new NineAgainTag(dn, gameObject, t);
    }
}
