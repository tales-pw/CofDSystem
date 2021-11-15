package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.game_object.traits.TraitType;

@:expose("EquipmentBonus")
class EquipmentBonus extends EquipmentMod
{
    public static final DN = "Equipment_Bonus";
    public static final TYPE = TraitType.createType(DN, EquipmentBonus.new);
}
