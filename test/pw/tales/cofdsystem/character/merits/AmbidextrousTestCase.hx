package pw.tales.cofdsystem.character.merits;

import pw.tales.cofdsystem.action.modifications.Offhand;
import pw.tales.cofdsystem.character.traits.merits.ambidextrous.AmbidextrousMerit;

class AmbidextrousTestCase extends CofDSystemTestCase
{
    public function testAmbidextrous():Void
    {
        var manager = c1.getTraitManager();
        assertEquals(-2, Offhand.getModifier(c1));

        var trait = manager.addTrait(AmbidextrousMerit.TYPE);
        assertEquals(0, Offhand.getModifier(c1));

        manager.removeTrait(trait);
        assertEquals(-2, Offhand.getModifier(c1));
    }
}
