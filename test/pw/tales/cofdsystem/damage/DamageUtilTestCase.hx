package pw.tales.cofdsystem.damage;

import haxe.unit.TestCase;

class DamageUtilTestCase extends TestCase
{
    public function testBallistic():Void
    {
        var damage = new Damage(0, 7, 0);
        damage.applyBallisticArmor(3);
        assertEquals(3, damage.getBashing());
        assertEquals(4, damage.getLethal());
        assertEquals(0, damage.getAggravated());
    }

    public function testGeneral():Void
    {
        var damage = new Damage(3, 4, 0);
        damage.applyGeneralArmor(4);
        assertEquals(3, damage.getBashing());
        assertEquals(0, damage.getLethal());
        assertEquals(0, damage.getAggravated());
    }

    public function testDamageDealt1():Void
    {
        var damage = DamageUtil.INSTANCE.simpleAbsorb(4, 3, new Damage(0, 7, 0));
        assertEquals(3, damage.getBashing());
        assertEquals(0, damage.getLethal());
        assertEquals(0, damage.getAggravated());
    }
}
