package pw.tales.cofdsystem.synchronization.serialization;

import haxe.Json;
import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;
import pw.tales.cofdsystem.synchronization.serialization.game_object.GameObjectSerialization;

class GameObjectSerializationTestCase extends CofDSystemTestCase
{
    public function testDeserialize()
    {
        var system_data = CompileTime.readFile("test/pw/tales/cofdsystem/synchronization/serialization/test_data/system_data_valid.json");
        var system = SystemSerialization.INSTANCE.deserialize(system_data);

        var serializer = new GameObjectSerialization(system);

        var data = CompileTime.readFile("test/pw/tales/cofdsystem/synchronization/serialization/test_data/go_data_valid.json");
        var gameObject = serializer.deserialize(data);

        var parsedData = Json.parse(data);

        this.assertEquals(gameObject.getTraitManager().getTraits().items().length, parsedData.traits.length);
    }
}
