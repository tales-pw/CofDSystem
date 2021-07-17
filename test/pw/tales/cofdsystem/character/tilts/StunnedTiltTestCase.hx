package pw.tales.cofdsystem.character.tilts;

import pw.tales.cofdsystem.character.traits.tilts.stunned.StunnedTilt;
import pw.tales.cofdsystem.character.traits.tilts.TiltType;

class StunnedTiltTestCase extends BaseTiltTestCase {
    public override function getTiltType():TiltType {
        return StunnedTilt.TYPE;
    }
}
