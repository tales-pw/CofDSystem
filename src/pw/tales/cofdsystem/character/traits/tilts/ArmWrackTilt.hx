package pw.tales.cofdsystem.character.traits.tilts;

import pw.tales.cofdsystem.game_object.traits.TraitType;

@:expose("ArmWrackTilt")
class ArmWrackTilt extends Tilt
{
    public static final DN = "Arm_Wrack";
    public static final TYPE = TraitType.createType(DN, ArmWrackTilt.new).setMultiInstanced(true);
}
