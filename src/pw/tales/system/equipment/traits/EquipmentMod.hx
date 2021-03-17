package pw.tales.system.equipment.traits;

import pw.tales.system.equipment.traits.EquipmentTrait;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

class EquipmentMod extends EquipmentTrait {
    @Serialize("value")
    private var value:Int = 0;

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>) {
        super(dn, gameObject, type);
    }

    public function setValue(value:Int) {
        this.value = value;
    }

    public override function getValue():Int {
        return this.value;
    }
}
