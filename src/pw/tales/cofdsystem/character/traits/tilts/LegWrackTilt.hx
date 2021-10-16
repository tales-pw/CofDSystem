package pw.tales.cofdsystem.character.traits.tilts;

import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class LegWrackTilt extends Tilt
{
    public static final DN = "Leg_Wrack";
    public static final TYPE = TraitType.createType(DN, LegWrackTilt.new).setMultiInstanced(true);
}
