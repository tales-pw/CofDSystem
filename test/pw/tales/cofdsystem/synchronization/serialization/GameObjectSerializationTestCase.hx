package pw.tales.cofdsystem.synchronization.serialization;

import haxe.Json;
import pw.tales.cofdsystem.character.prefabs.PlayerPrefab;
import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;
import pw.tales.cofdsystem.synchronization.serialization.game_object.GameObjectSerialization;

class GameObjectSerializationTestCase extends CofDSystemTestCase
{
    public function test():Void
    {
        var gameObject1 = PlayerPrefab.INSTANCE.createGameObject(this.system);

        var serializer = new GameObjectSerialization(this.system);

        // Deserialize
        var data = serializer.serialize(gameObject1);

        // Serialize
        var gameObject2 = serializer.deserialize(data);

        this.assertGOEquals(gameObject1, gameObject2);
    }

    public function methodTestDeserialize(serializedData:String):Void
    {
        var system = SystemSerialization.INSTANCE.deserialize(TestData.SYSTEM_VALID_DATA);

        var serializer = new GameObjectSerialization(system);

        var gameObject = serializer.deserialize(serializedData);
        serializer.serialize(gameObject);

        var data = Json.parse(serializedData);

        this.assertEquals(data.dn, gameObject.getDN());

        var traitDatas:Array<Dynamic> = data.traits;
        for (traitData in traitDatas)
        {
            var trait = gameObject.getTraitManager().getTraitByDn(traitData.dn);

            this.assertNotEquals(trait, null);
            this.assertEquals(trait.getType().getDN(), traitData.type);
        }
    }

    public function testDeserialize_09_12_2021():Void
    {
        this.methodTestDeserialize(TestData.GO_DATA);
    }
}
