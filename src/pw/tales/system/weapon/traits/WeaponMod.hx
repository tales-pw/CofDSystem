package pw.tales.system.weapon.traits;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

class WeaponMod extends WeaponTrait {
    @Serialize("value")
    private var value:Int = 0;

    public function new<T:WeaponMod>(dn:String, gameObject:GameObject, type:TraitType<T>) {
        super(dn, gameObject, type);
    }

    public function setValue(value:Int) {
        this.value = value;
        this.notifyUpdated();
    }

    public override function getValue():Int {
        return this.value;
    }
}