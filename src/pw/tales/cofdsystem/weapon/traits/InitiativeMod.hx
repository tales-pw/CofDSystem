package pw.tales.cofdsystem.weapon.traits;

import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("InitiativeMod")
class InitiativeMod extends WeaponMod
{
    public static final DN = "Свойство:Initiative";
    public static final TYPE = TraitType.createType(DN, InitiativeMod.new);
}
