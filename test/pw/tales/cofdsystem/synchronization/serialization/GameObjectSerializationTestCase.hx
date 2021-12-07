package pw.tales.cofdsystem.synchronization.serialization;

import pw.tales.cofdsystem.character.prefabs.PlayerPrefab;
import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;
import pw.tales.cofdsystem.synchronization.serialization.game_object.GameObjectSerialization;

class GameObjectSerializationTestCase extends CofDSystemTestCase
{
    public function testDeserialize()
    {
        var system = SystemSerialization.INSTANCE.deserialize(TestData.SYSTEM_VALID_DATA);

        var serializer = new GameObjectSerialization(system);

        var gameObject1 = PlayerPrefab.INSTANCE.createGameObject(system);

        // Deserialize
        var data = serializer.serialize(gameObject1);

        // Serialize
        var gameObject2 = serializer.deserialize(data);

        this.assertGOEquals(gameObject1, gameObject2);
    }
}
