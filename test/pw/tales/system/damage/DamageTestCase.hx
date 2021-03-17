package pw.tales.system.damage;

import pw.tales.system.damage.Damage;

class DamageTestCase extends haxe.unit.TestCase {
    public function assertDamage(expecitedB:Int, expectedL:Int, expectedA:Int, damage:Damage) {
        assertEquals(expecitedB, damage.getBashing());
        assertEquals(expectedL, damage.getLethal());
        assertEquals(expectedA, damage.getAggravated());
    }

    public function testBallistic() {
        // Ignores bashing
        var damage = new Damage(3, 0, 0);
        damage.applyBallisticArmor(3);
        assertDamage(3, 0, 0, damage);

        // Ignores aggravated
        var damage = new Damage(0, 0, 4);
        damage.applyBallisticArmor(3);
        assertDamage(0, 0, 4, damage);

        // Doesn't overwrite bashing
        var damage = new Damage(1, 2, 0);
        damage.applyBallisticArmor(3);
        assertDamage(3, 0, 0, damage);

        // Overflows correctly
        var damage = new Damage(0, 5, 0);
        damage.applyBallisticArmor(3);
        assertDamage(3, 2, 0, damage);
    }

    public function testGeneral() {
        // Esnure absorb priorities
        var damage = new Damage(2, 2, 2);
        damage.applyGeneralArmor(1);
        assertDamage(2, 2, 1, damage);

        var damage = new Damage(2, 2, 0);
        damage.applyGeneralArmor(1);
        assertDamage(2, 1, 0, damage);

        var damage = new Damage(2, 0, 0);
        damage.applyGeneralArmor(1);
        assertDamage(1, 0, 0, damage);

        // Esnure nobody puts 1 bashing armor rule in damage (as it works only for armor)
        var damage = new Damage(1, 0, 0);
        damage.applyGeneralArmor(1);
        assertDamage(0, 0, 0, damage);
    }

    public function testRulebookExample() {
        var damage = new Damage(0, 3, 0);
        damage.applyBallisticArmor(3);
        damage.applyGeneralArmor(1);
        assertDamage(2, 0, 0, damage);
    }
}
