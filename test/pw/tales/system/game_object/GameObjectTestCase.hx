package pw.tales.system.game_object;

import pw.tales.system.character.traits.attribute.Attributes;

class GameObjectTestCase extends haxe.unit.TestCase {
    public final system:CofDSystem = new CofDSystem();

    public function testDeactivate() {
        var gameObject = new GameObject("game_object", system);
        gameObject.getTraitManager().addTrait(Attributes.STRENGTH);
        gameObject.deactivate();

        assertEquals(GameObjectState.INACTIVE, gameObject.getState());
    }
}
