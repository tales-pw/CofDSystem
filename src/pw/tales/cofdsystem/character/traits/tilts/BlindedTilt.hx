package pw.tales.cofdsystem.character.traits.tilts;

import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class BlindedTilt extends Tilt
{
    public static final DN = "Blinded";
    public static final TYPE = TraitType.createType(DN, BlindedTilt.new).setMultiInstanced(true);
}
