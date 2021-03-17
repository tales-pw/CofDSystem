package pw.tales.system.equipment.traits;

import pw.tales.system.equipment.traits.EquipmentMod;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

class EquipmentBonus extends EquipmentMod {
    public static final DN = "Equipment_Bonus";
    public static final TYPE = TraitType.createType(DN, create);

    public function new(dn:String, gameObject:GameObject) {
        super(dn, gameObject, TYPE);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<EquipmentBonus>):EquipmentBonus {
        return new EquipmentBonus(dn, gameObject);
    }
}
