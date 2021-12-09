package pw.tales.cofdsystem.character.merits;

import pw.tales.cofdsystem.common.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.character.traits.merits.giant.GiantMerit;

class SmallFramedTestCase extends CofDSystemTestCase
{
    public function testSmallFramed():Void
    {
        var manager = c1.getTraitManager();

        var size = manager.getTrait(SizeAdvantage.TYPE);
        assertEquals(5, size.getValue());

        var giant = manager.addTrait(GiantMerit.TYPE);
        assertEquals(6, size.getValue());

        manager.removeTrait(giant);
        assertEquals(5, size.getValue());
    }
}
