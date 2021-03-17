package pw.tales.system.character.merits;

import pw.tales.system.character.traits.advantages.SizeAdvantage;
import pw.tales.system.character.traits.merits.giant.GiantMerit;

class SmallFramedTestCase extends CofDSystemTestCase {
    public function testSmallFramed() {
        var manager = c1.getTraitManager();

        var size:SizeAdvantage = cast(manager.getTrait(SizeAdvantage.TYPE));
        assertEquals(5, size.getValue());

        var giant = manager.addTrait(GiantMerit.TYPE);
        assertEquals(6, size.getValue());

        manager.removeTrait(giant);
        assertEquals(5, size.getValue());
    }
}
