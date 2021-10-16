package pw.tales.cofdsystem.character.tilts;

import pw.tales.cofdsystem.character.traits.tilts.StunnedTilt;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class StunnedTiltTestCase extends BaseTiltTestCase
{
    public override function getTiltType():TraitType<Dynamic>
    {
        return StunnedTilt.TYPE;
    }
}
