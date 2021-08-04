package pw.tales.cofdsystem.character.tilts;

import pw.tales.cofdsystem.character.traits.tilts.blinded.BlindedTilt;
import pw.tales.cofdsystem.character.traits.tilts.TiltType;

class BlindedTiltTestCase extends BaseTiltTestCase
{
    public override function getTiltType():TiltType
    {
        return BlindedTilt.TYPE;
    }
}
