package pw.tales.cofdsystem.character.tilts;

import pw.tales.cofdsystem.character.traits.tilts.ArmWrackTilt;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class ArmWrackTiltTestCase extends BaseTiltTestCase
{
    public override function getTiltType():TraitType<Dynamic>
    {
        return ArmWrackTilt.TYPE;
    }
}
