package pw.tales.cofdsystem.synchronization.api;

import pw.tales.cofdsystem.synchronization.serialization.system.SystemSerialization;

@:nullSafety(Off)
@:expose("SystemStorage")
class SystemStorage
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
        var serialization = SystemSerialization.INSTANCE;
        serialization.update(system, serializedData);
        this.onSuccess();
    }

    public function update(system:CofDSystem):Void
    {
        var http = new haxe.Http('${host}/system');

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
