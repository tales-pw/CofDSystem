package pw.tales.cofdsystem.damage;

@:expose("DamageUtil")
class DamageUtil
{
    public static final INSTANCE:DamageUtil = new DamageUtil();

    public function new() {}

    public function simpleAbsorb(general:Int, ballistic:Int, damage:Damage, armor:Bool = true):Damage
    {
        damage.applyBallisticArmor(ballistic);
        damage.applyGeneralArmor(general);
        if (armor)
            damage.enusreBashing();
        return damage;
    }
}
