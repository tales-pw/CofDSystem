package pw.tales.cofdsystem.character.traits.tilts;

import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("StunnedTilt")
class StunnedTilt extends Tilt
{
    public static final DN = "Stunned";
    public static final TYPE = TraitType.createType(DN, StunnedTilt.new).setMultiInstanced(true);
}
