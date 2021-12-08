package pw.tales.cofdsystem.synchronization.api.mock;

class HttpMock extends haxe.http.HttpBase
{
    private var data:Null<Dynamic>;

    public function new(url:String, data:Null<Dynamic> = null)
    {
        super(url);
        this.data = data;
    }

    public function setData(data:Null<Dynamic>):Void
    {
        this.data = data;
    }

    public override function request(post:Bool = null):Void
    {
        if (this.data == null)
        {
            throw "No data set for HttpMock.";
        }

        this.onData(this.data);
    }
}
