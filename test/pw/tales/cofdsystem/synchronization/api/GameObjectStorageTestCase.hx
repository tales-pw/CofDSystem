package pw.tales.cofdsystem.synchronization.api;

import haxe.Json;
import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;

class GameObjectStorageTestCase extends APIStorageTestCase
{
    private final DN:String = "dn";
    private final TOKEN:String = "token";

    @:nullSafety(Off)
    private var system:CofDSystem = null;

    @:nullSafety(Off)
    private var storage:GameObjectStorage = null;

    public override function setup():Void
    {
        super.setup();
        this.system = SystemSerialization.INSTANCE.deserialize(TestData.SYSTEM_VALID_DATA);
        this.storage = GameObjectStorage.createForClient(this.DOMAIN, this.system, this.TOKEN);
        this.storage.createHttp = this.mockCreateHttp();
    }

    public function testSuccessfulFetch():Void
    {
        this.httpMock.setData(Json.stringify({
            type: "game_object",
            game_object: Json.parse(TestData.GO_DATA)
        }));

        var onGameObjectCalled = false;
        this.storage.onGameObject = (go) ->
        {
            onGameObjectCalled = true;
        }

        this.storage.read(this.DN);

        this.assertEquals(
            httpMock.url,
            '${this.DOMAIN}/game_objects/${this.DN}'
        );
        this.assertTrue(onGameObjectCalled);
    }
}
