package pw.tales.cofdsystem.synchronization.api;

import haxe.Json;

@:nullSafety(Off)
@:expose("SystemStorage")
class SystemStorage extends APIStorage
{
    public static final ROUTE:String = "system";

    private final host:String;

    public function new(host:String)
    {
        this.host = host;
    }

    private dynamic function onSuccess():Void {}

    private function handleResponse(system:CofDSystem, serializedData:String):Void
    {
        system.updateWithData(Json.parse(serializedData));
        this.onSuccess();
    }

    public function update(system:CofDSystem):Void
    {
        var http = this.createHttp('${host}/system');

        http.onData = function(serializedData:String)
        {
            handleResponse(system, serializedData);
        };

        http.onError = function(error)
        {
            throw 'HttpException ${error}';
        };

        http.request();
    }
}
