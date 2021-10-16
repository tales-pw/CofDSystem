package pw.tales.cofdsystem.character.tilts;

import pw.tales.cofdsystem.character.traits.tilts.BlindedTilt;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class BlindedTiltTestCase extends BaseTiltTestCase
{
    public override function getTiltType():TraitType<Dynamic>
    {
        return BlindedTilt.TYPE;
    }
}
