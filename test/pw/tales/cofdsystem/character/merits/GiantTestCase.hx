package pw.tales.cofdsystem.character.merits;

import pw.tales.cofdsystem.game_object.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.character.traits.merits.giant.GiantMerit;

class GiantTestCase extends CofDSystemTestCase
{
    public function testGiant():Void
    {
        var manager = c1.getTraitManager();

        var size:SizeAdvantage = cast(manager.getTrait(SizeAdvantage.TYPE));
        assertEquals(5, size.getValue());

        var giant = manager.addTrait(GiantMerit.TYPE);
        assertEquals(6, size.getValue());

        manager.removeTrait(giant);
        assertEquals(5, size.getValue());
    }
}
