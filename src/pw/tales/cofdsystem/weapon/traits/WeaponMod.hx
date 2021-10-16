package pw.tales.cofdsystem.weapon.traits;

class WeaponMod extends WeaponTrait
{
    @Serialize("value")
    private var value:Int = 0;

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
