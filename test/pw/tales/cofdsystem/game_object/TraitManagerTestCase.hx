package pw.tales.cofdsystem.game_object;

import pw.tales.cofdsystem.game_object.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.character.traits.merits.giant.GiantMerit;
import haxe.unit.TestCase;

@:nullSafety(Off)
class TraitManagerTestCase extends TestCase
{
    public function testAddAndRemoveTrait():Void
    {
        // TODO: better tests for TraitManager.
        var system = new CofDSystem();
        var gameObject = new GameObject("game_object", system);
        var manager = gameObject.getTraitManager();

        var size = manager.addTrait(SizeAdvantage.TYPE);
        assertEquals(5, size.getValue());

        var giant = manager.addTrait(GiantMerit.TYPE);
        assertEquals(6, size.getValue());

        manager.removeTrait(giant);
        assertEquals(5, size.getValue());
    }
}
