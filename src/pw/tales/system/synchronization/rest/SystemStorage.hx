package pw.tales.system.synchronization.rest;

import pw.tales.system.synchronization.rest.exception.VersionMissmatchException;
import pw.tales.system.synchronization.rest.serialization.APIAbilitySerialization;
import pw.tales.system.synchronization.rest.serialization.APIArmorSerialization;
import pw.tales.system.synchronization.rest.serialization.APIConditionSerialization;
import pw.tales.system.synchronization.rest.serialization.APIMeleeSerialization;
import pw.tales.system.synchronization.rest.serialization.APIRangedSerialization;
import pw.tales.system.synchronization.rest.serialization.APITagSerialization;
import pw.tales.system.synchronization.rest.serialization.APITiltSerialization;

@:keep
@:expose("SystemStorage")
@:nullSafety(Off)
class SystemStorage {
    public static final ROUTE:String = "system";

    private final host:String;

    private final handlers:Array<ISerialization> = [
        APIAbilitySerialization.INSTANCE,
        APIConditionSerialization.INSTANCE,
        APITiltSerialization.INSTANCE,
        APIArmorSerialization.INSTANCE,
        APIMeleeSerialization.INSTANCE,
        APIRangedSerialization.INSTANCE,
        APITagSerialization.INSTANCE
    ];

    public function new(host:String) {
        this.host = host;
    }

    private dynamic function onSuccess() {
    }

    private function handleResponse(system:CofDSystem, serializedData:String) {
        var data:Dynamic = haxe.Json.parse(serializedData);

        var remoteVersion:String = data.version;
        if (CofDSystem.versionCheck && remoteVersion != CofDSystem.version) {
            throw new VersionMissmatchException(CofDSystem.version, remoteVersion);
        }

        for (handler in handlers) {
            handler.handle(system, data);
        }

        this.onSuccess();
    }

    public function update(system:CofDSystem) {
        var http = new haxe.Http('${host}/system');

        http.onData = function(serializedData:String) {
            handleResponse(system, serializedData);
        };

        http.onError = function(error) {
            throw 'HttpException ${error}';
        };

        http.request();
    }
}