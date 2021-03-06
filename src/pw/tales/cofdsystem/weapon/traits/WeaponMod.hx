package pw.tales.cofdsystem.weapon.traits;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class WeaponMod extends WeaponTrait
{
    @Serialize("value")
    private var value:Int = 0;

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
    }

    public function setValue(value:Int)
    {
        this.value = value;
        this.notifyUpdated();
    }

    public override function getValue():Int
    {
        return this.value;
    }
}
