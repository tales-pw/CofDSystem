package pw.tales.cofdsystem.character.tilts;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.character.traits.tilts.LegWrackTilt;

class LegWrackTiltTestCase extends BaseTiltTestCase
{
    public override function getTiltType():TraitType<Dynamic>
    {
        return LegWrackTilt.TYPE;
    }
}
