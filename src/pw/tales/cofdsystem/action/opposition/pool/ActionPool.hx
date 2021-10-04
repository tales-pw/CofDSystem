package pw.tales.cofdsystem.action.opposition.pool;

import pw.tales.cofdsystem.dices.requests.RollRequestTrait;
import pw.tales.cofdsystem.dices.RollResponse;
import pw.tales.cofdsystem.game_object.GameObject;

@:nullSafety(Off)
class ActionPool
{
    private var gameObject:GameObject;
    private var marks:Array<String> = [];

    private var request:RollRequestTrait;
    private var response:RollResponse;

    public function new(gameObject:GameObject, traits:Array<String>)
    {
        this.gameObject = gameObject;
        this.request = new RollRequestTrait(gameObject, traits);
    }

    public function getGameObject():GameObject
    {
        return this.gameObject;
    }

    public function getTraits():Array<String>
    {
        return this.request.getTraits();
    }

    public function hasTrait(dn:String):Bool
    {
        return this.getTraits().indexOf(dn) != -1;
    }

    public function getRequest():RollRequestTrait
    {
        return this.request;
    }

    public function getResponse():RollResponse
    {
        return this.response;
    }

    public function roll(system:CofDSystem):RollResponse
    {
        this.response = system.dices.roll(request);
        return this.response;
    }
}
