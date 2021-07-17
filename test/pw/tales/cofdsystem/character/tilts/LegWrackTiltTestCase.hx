package pw.tales.cofdsystem.character.tilts;

import pw.tales.cofdsystem.character.traits.tilts.leg_wrack.LegWrackTilt;
import pw.tales.cofdsystem.character.traits.tilts.TiltType;

class LegWrackTiltTestCase extends BaseTiltTestCase {
    public override function getTiltType():TiltType {
        return LegWrackTilt.TYPE;
    }
}
