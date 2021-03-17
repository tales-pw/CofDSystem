package pw.tales.system.character.merits;

import pw.tales.system.action.modifications.Offhand;
import pw.tales.system.character.traits.merits.ambidextrous.AmbidextrousMerit;
import pw.tales.system.game_object.GameObject;

class AmbidextrousTestCase extends CofDSystemTestCase {
    public function getOffhandModifer(gameObject:GameObject) {
        return Offhand.getModifier(gameObject);
    }

    function testAmbidextrous() {
        var manager = c1.getTraitManager();
        assertEquals(-2, this.getOffhandModifer(c1));

        var trait = manager.addTrait(AmbidextrousMerit.TYPE);
        assertEquals(0, this.getOffhandModifer(c1));

        manager.removeTrait(trait);
        assertEquals(-2, this.getOffhandModifer(c1));
    }
}
