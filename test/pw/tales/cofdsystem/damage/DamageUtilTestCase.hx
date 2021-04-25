package pw.tales.cofdsystem.damage;

class DamageUtilTestCase extends haxe.unit.TestCase {
    public function testBallistic() {
        var damage = new Damage(0, 7, 0);
        damage.applyBallisticArmor(3);
        assertEquals(3, damage.getBashing());
        assertEquals(4, damage.getLethal());
        assertEquals(0, damage.getAggravated());
    }

    public function testGeneral() {
        var damage = new Damage(3, 4, 0);
        damage.applyGeneralArmor(4);
        assertEquals(3, damage.getBashing());
        assertEquals(0, damage.getLethal());
        assertEquals(0, damage.getAggravated());
    }

    public function testDamageDealt1() {
        var damage = DamageUtil.INSTANCE.simpleAbsorb(4, 3, new Damage(0, 7, 0));
        assertEquals(3, damage.getBashing());
        assertEquals(0, damage.getLethal());
        assertEquals(0, damage.getAggravated());
    }
}
