package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.game_object.traits.TraitType;

class EquipmentBonus extends EquipmentMod
{
    public static final DN = "Equipment_Bonus";
    public static final TYPE:TraitType<EquipmentBonus> = TraitType.createType(DN, EquipmentBonus.new);
}
