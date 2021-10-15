package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.equipment.traits.EquipmentTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class EquipmentMod extends EquipmentTrait
{
    @Serialize("value")
    private var value:Int = 0;

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
    }

    public function setValue(value:Int):Void
    {
        this.value = value;
        this.notifyUpdated();
    }

    public override function getValue():Int
    {
        return this.value;
    }
}
