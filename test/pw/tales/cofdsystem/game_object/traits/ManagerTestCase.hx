package pw.tales.cofdsystem.game_object.traits;

import pw.tales.cofdsystem.character.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.character.traits.merits.giant.GiantMerit;
import haxe.unit.TestCase;

@:nullSafety(Off)
class ManagerTestCase extends TestCase
{
    public function testAddAndRemoveTrait()
    {
        // TODO: better tests for TraitManager.
        var system = new CofDSystem();
        var gameObject = new GameObject("game_object", system);
        var manager = gameObject.getTraitManager();

        manager.addTrait(SizeAdvantage.TYPE);

        var size:SizeAdvantage = cast manager.getTrait(SizeAdvantage.TYPE);
        assertEquals(5, size.getValue());

        var giant:GiantMerit = cast manager.addTrait(GiantMerit.TYPE);
        assertEquals(6, size.getValue());

        manager.removeTrait(giant);
        assertEquals(5, size.getValue());
    }
}
