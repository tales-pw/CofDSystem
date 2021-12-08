package pw.tales.cofdsystem.synchronization.api;

import haxe.http.HttpBase;
import pw.tales.cofdsystem.synchronization.api.mock.HttpMock;
import haxe.unit.TestCase;

typedef RequestCallback = (?Null<Bool>) -> Void;
typedef CreateHttpCallback = (url:String) -> HttpBase;

class APIStorageTestCase extends TestCase implements WithBaseTest
{
    private final DOMAIN:String = "http://domain";

    @:nullSafety(Off)
    private var httpMock:HttpMock = null;

    public override function setup():Void
    {
        super.setup();
        this.httpMock = new HttpMock("");
    }

    private function mockCreateHttp():CreateHttpCallback
    {
        return (url:String) ->
        {
            this.httpMock.url = url;
            return this.httpMock;
        }
    }

    public function getBaseTest():Class<TestCase>
    {
        return APIStorageTestCase;
    }
}
