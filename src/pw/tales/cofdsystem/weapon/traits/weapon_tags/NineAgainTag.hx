package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   9-Again weapon tag.
 *
 *   @see <https://tales.pw/page/9-again_(weapon_tag)>
**/
@RegisterTraitTypes
@:expose("NineAgainTag")
class NineAgainTag extends ExplodeTag
{
    public static final DN = "9-again_(weapon_tag)";
    public static final TYPE = cast TraitType.createType(DN, NineAgainTag.new);

    public override function getExplode():EnumExplode
    {
        return EnumExplode.NINE_AGAIN;
    }
}
