package pw.tales.cofdsystem.synchronization.serialization;

import haxe.Json;
import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;
import pw.tales.cofdsystem.synchronization.serialization.game_object.GameObjectSerialization;

class GameObjectSerializationTestCase extends CofDSystemTestCase
{
    public function testDeserialize()
    {
        var system = SystemSerialization.INSTANCE.deserialize(TestData.SYSTEM_VALID_DATA);

        var serializer = new GameObjectSerialization(system);

        var gameObject = serializer.deserialize(TestData.GO_VALID_DATA);
        var parsedData = Json.parse(TestData.GO_VALID_DATA);

        this.assertEquals(gameObject.getTraitManager().getTraits().items().length, parsedData.traits.length);
    }
}
