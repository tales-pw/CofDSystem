package pw.tales.cofdsystem.character.tilts;

import pw.tales.cofdsystem.character.traits.tilts.arm_wrack.ArmWrackTilt;
import pw.tales.cofdsystem.character.traits.tilts.TiltType;

class ArmWrackTiltTestCase extends BaseTiltTestCase
{
    public override function getTiltType():TiltType
    {
        return ArmWrackTilt.TYPE;
    }
}
