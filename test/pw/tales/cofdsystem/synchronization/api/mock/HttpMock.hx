package pw.tales.cofdsystem.synchronization.api.mock;

class HttpMock extends haxe.http.HttpBase
{
    public dynamic function requestDynamic(?post:Bool):Void {}

    public override function request(?post:Bool):Void
    {
        this.requestDynamic(post);
    }
}
