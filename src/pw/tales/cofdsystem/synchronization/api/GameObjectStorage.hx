package pw.tales.cofdsystem.synchronization.api;

import haxe.http.HttpBase;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;

@:nullSafety(Off)
@:expose("GameObjectStorage")
class GameObjectStorage extends APIStorage
{
    // Response types
    public static final GAME_OBJECT:String = "game_object";
    public static final UPDATED:String = "updated";
    public static final ERROR:String = "error";

    private final host:String;
    private final system:CofDSystem;

    private var clientToken:String = null;
    private var serverToken:String = null;

    private function new(host:String, system:CofDSystem)
    {
        this.host = host;
        this.system = system;
    }

    public static function createForClient(host:String, system:CofDSystem, token:String):GameObjectStorage
    {
        var storage = new GameObjectStorage(host, system);
        storage.setClientToken(token);
        return storage;
    }

    public static function createForServer(host:String, system:CofDSystem, token:String):GameObjectStorage
    {
        var storage = new GameObjectStorage(host, system);
        storage.setServerToken(token);
        return storage;
    }

    public dynamic function onGameObject(gameObject:GameObject):Void {}

    public dynamic function onUpdated(version:String):Void {}

    public dynamic function onError(data:Dynamic, context:Dynamic):Void {}

    private function setClientToken(token:String):Void
    {
        this.clientToken = token;
    }

    private function setServerToken(token:String):Void
    {
        this.serverToken = token;
    }

    private function handleResponse(serializedData:Null<String>, context:Dynamic):Void
    {
        if (serializedData == null)
            throw "No data";

        var data:Dynamic = haxe.Json.parse(serializedData);

        if (data.type == GAME_OBJECT)
        {
            var goData = data.game_object;
            var gameObject:GameObject;

            if (context.gameObject)
            {
                // We tried to update outdated game object.
                // Instead of update full update game object
                // is recieved.
                gameObject = context.gameObject;
                gameObject.updateWithData(goData);
            } else
            {
                // Create new game object from recieved data.
                gameObject = GameObject.fromData(system, goData);
            }

            this.onGameObject(gameObject);
            return;
        }

        if (data.type == UPDATED)
        {
            var gameObject:GameObject = context.gameObject;
            gameObject.version = data.version;
            this.onUpdated(data.version);
            return;
        }

        this.onError(data, context);
    }

    private function addTokenToRequest(request:HttpBase):Void
    {
        if (this.serverToken != null)
        {
            request.addHeader("Server-Token", this.serverToken);
            return;
        }

        if (this.clientToken != null)
        {
            request.addHeader("Client-Token", this.clientToken);
            return;
        }

        throw "No server or client token set, use factory methods instead of constructor";
    }

    private function prepareRequest(url:String, context:Dynamic = null):HttpBase
    {
        if (context == null)
            context = {};

        var request = this.createHttp(url);

        request.addHeader("Content-Type", "application/json");
        this.addTokenToRequest(request);

        request.onData = function(data)
        {
            handleResponse(data, context);
        };

        request.onError = function(error)
        {
            handleResponse(request.responseData, context);
        };

        return request;
    }

    public function create(dn:String, traitTypes:Array<String> = null):Void
    {
        var http = prepareRequest('${host}/game_objects/${dn}', {
            "dn": dn,
            "traitTypes": traitTypes
        });

        var data:Dynamic = {};
        if (traitTypes != null)
            data = {
                "traitTypes": traitTypes
            };

        http.setPostData(haxe.Json.stringify(data));
        http.request(true);
    }

    public function read(dn:String):Void
    {
        var http = prepareRequest('${host}/game_objects/${dn}', {
            "dn": dn
        });
        http.request();
    }

    public function update(gameObject:GameObject, update:Array<Trait> = null, remove:Array<String> = null):Void
    {
        if (update == null)
            update = [];

        if (remove == null)
            remove = [];

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
