package pw.tales.cofdsystem.game_object;

import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import haxe.unit.TestCase;

class GameObjectTestCase extends TestCase
{
    public final system:CofDSystem = new CofDSystem();

    public function testDeactivate():Void
    {
        var gameObject = new GameObject("game_object", system);
        gameObject.getTraitManager().addTrait(Attributes.STRENGTH);
        gameObject.deactivate();

        assertEquals(GameObjectState.INACTIVE, gameObject.getState());
    }
}
