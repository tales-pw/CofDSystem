package pw.tales.cofdsystem.synchronization.api;

import pw.tales.cofdsystem.synchronization.api.mock.HttpMock;
import haxe.unit.TestCase;

class SystemStorageTestCase extends TestCase
{
    private static final DOMAIN:String = "http://domain";

    @:nullSafety(Off)
    private var httpMock:HttpMock = null;

    @:nullSafety(Off)
    private var storage:SystemStorage = null;

    private function initStorage(requestCallback:(?Null<Bool>) -> Void):Void
    {
        this.storage = new SystemStorage(DOMAIN);

        this.storage.prepareRequest = (url:String) ->
        {
            this.httpMock = new HttpMock(url);
            this.httpMock.requestDynamic = requestCallback;

            return this.httpMock;
        };
    }

    public function testDeserialize()
    {
        this.initStorage((?post:Null<Bool>) ->
        {
            this.httpMock.onData(TestData.SYSTEM_VALID_DATA);
        });

        var system = new CofDSystem();
        this.storage.update(system);

        this.assertEquals(httpMock.url, '${DOMAIN}/system');
        this.assertTrue(new CofDSystem().traits.items().length < system.traits.items().length);
    }
}
