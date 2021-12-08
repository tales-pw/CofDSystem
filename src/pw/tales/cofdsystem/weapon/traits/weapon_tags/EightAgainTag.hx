package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   8-Again weapon tag.
 *
 *   @see <https://tales.pw/page/8-again_(weapon_tag)>
**/
@RegisterTraitTypes
@:expose("EightAgainTag")
class EightAgainTag extends ExplodeTag
{
    public static final DN = "8-again_(weapon_tag)";
    public static final TYPE = cast TraitType.createType(DN, EightAgainTag.new);

    public override function getExplode():EnumExplode
    {
        return EnumExplode.EIGHT_AGAIN;
    }
}
