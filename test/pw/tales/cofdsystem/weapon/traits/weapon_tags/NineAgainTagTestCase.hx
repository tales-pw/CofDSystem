package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.dices.EnumExplode;

class NineAgainTagTestCase extends ExplodeTagTestCase
{
    public override function getTagType():TraitType<ExplodeTag>
    {
        return cast NineAgainTag.TYPE;
    }

    public override function getExpectedExplode():EnumExplode
    {
        return EnumExplode.NINE_AGAIN;
    }
}
