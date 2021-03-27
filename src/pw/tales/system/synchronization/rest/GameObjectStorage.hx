package pw.tales.system.synchronization.rest;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.synchronization.GameObjectSynchronization;

@:expose("GameObjectStorage")
@:nullSafety(Off)
class GameObjectStorage {
    // Response types
    public static final GAME_OBJECT:String = "game_object";
    public static final UPDATED:String = "updated";
    public static final ERROR:String = "error";

    private final host:String;
    private final system:CofDSystem;

    private var clientToken:String = null;
    private var serverToken:String = null;

    private function new(host:String, system:CofDSystem) {
        this.host = host;
        this.system = system;
    }

    public static function createForClient(host:String, system:CofDSystem, token:String):GameObjectStorage {
        var storage = new GameObjectStorage(host, system);
        storage.setClientToken(token);
        return storage;
    }

    public static function createForServer(host:String, system:CofDSystem, token:String):GameObjectStorage {
        var storage = new GameObjectStorage(host, system);
        storage.setServerToken(token);
        return storage;
    }

    public dynamic function onGameObject(gameObject:GameObject) {
    }

    public dynamic function onUpdated(version:String) {
    }

    public dynamic function onError(data:Dynamic, context:Dynamic) {
    }

    public function setClientToken(token:String) {
        this.clientToken = token;
    }

    public function setServerToken(token:String) {
        this.serverToken = token;
    }

    private function handleResponse(serializedData:Null<String>, context:Dynamic) {
        if (serializedData == null) throw "No data";

        var data:Dynamic = haxe.Json.parse(serializedData);

        if (data.type == GAME_OBJECT) {
            var deserializer = GameObjectSynchronization.createDeserializer(system, context.gameObject);
            this.onGameObject(deserializer.fromData(data.game_object));
            return;
        }

        if (data.type == UPDATED) {
            var gameObject:GameObject = context.gameObject;
            gameObject.version = data.version;
            this.onUpdated(data.version);
            return;
        }

        this.onError(data, context);
    }

    private function addTokenToRequest(request:haxe.Http) {
        if (this.serverToken != null) {
            request.addHeader("Server-Token", this.serverToken);
            return;
        }

        if (this.clientToken != null) {
            request.addHeader("Client-Token", this.clientToken);
            return;
        }

        throw "No server or client token set, use factory methods instead of constructor";
    }

    public function prepareRequest(url:String, context:Dynamic = null):haxe.Http {
        if (context == null) context = {};

        var request = new haxe.Http(url);

        request.addHeader("Content-Type", "application/json");
        this.addTokenToRequest(request);

        request.onData = function(data) {
            handleResponse(request.responseData, context);
        };

        request.onError = function(error) {
            handleResponse(request.responseData, context);
        };

        return request;
    }

    public function create(dn:String, traitTypes:Array<String> = null) {
        var http = prepareRequest('${host}/game_objects/${dn}', {
            "dn": dn,
            "traitTypes": traitTypes
        });

        var data:Dynamic = {};
        if (traitTypes != null) data = {"traitTypes": traitTypes};

        http.setPostData(haxe.Json.stringify(data));
        http.request(true);
    }

    public function read(dn:String) {
        var http = prepareRequest('${host}/game_objects/${dn}', {"dn": dn});
        http.request();
    }

    public function update(gameObject:GameObject, update:Array<Trait> = null, remove:Array<String> = null) {
        if (update == null) update = [];
        if (remove == null) remove = [];

        var http = prepareRequest('${host}/game_objects/${gameObject.getDN()}/update', {
            "gameObject": gameObject
        });

        http.setPostData(haxe.Json.stringify({
            "version": gameObject.version,
            "update": [for (trait in update) trait.serialize()],
            "remove": remove
        }));

        http.request(true);
    }
}
