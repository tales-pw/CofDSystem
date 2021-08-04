package pw.tales.cofdsystem.synchronization.rest;

import pw.tales.cofdsystem.serialization.system.SystemData;
import pw.tales.cofdsystem.serialization.system.SystemSerializer;
import pw.tales.cofdsystem.synchronization.rest.exception.VersionMissmatchException;

@:expose("SystemStorage")
@:nullSafety(Off)
class SystemStorage
{
    private static final systemSerializer = new SystemSerializer();

    public static final ROUTE:String = "system";

    private final host:String;

    public function new(host:String)
    {
        this.host = host;
    }

    private dynamic function onSuccess() {}

    private function handleResponse(system:CofDSystem, serializedData:String)
    {
        var data:SystemData = haxe.Json.parse(serializedData);

        var remoteVersion:String = data.version;
        if (CofDSystem.versionCheck && remoteVersion != CofDSystem.version)
        {
            throw new VersionMissmatchException(CofDSystem.version, remoteVersion);
        }

        systemSerializer.updateWithData(system, data);

        this.onSuccess();
    }

    public function update(system:CofDSystem)
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
