package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.ExplodeTagTestCase;

class EightAgainTagTestCase extends ExplodeTagTestCase
{
    public override function getTagType():TraitType<ExplodeTag>
    {
        return cast EightAgainTag.TYPE;
    }

    public override function getExpectedExplode():EnumExplode
    {
        return EnumExplode.EIGHT_AGAIN;
    }
}
