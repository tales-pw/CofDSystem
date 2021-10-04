package pw.tales.cofdsystem.action.pool;

import pw.tales.cofdsystem.action.events.roll.ActionPostRollEvent;
import pw.tales.cofdsystem.action.events.roll.ActionPreRollEvent;
import pw.tales.cofdsystem.dices.requests.RollRequestTrait;
import pw.tales.cofdsystem.dices.RollResponse;
import pw.tales.cofdsystem.game_object.GameObject;

@:nullSafety(Off)
class ActionPool implements IActionRoll
{
    private final gameObject:GameObject;
    private final system:CofDSystem;

    private var request:RollRequestTrait;
    private var response:RollResponse;

    public function new(gameObject:GameObject, traits:Array<String>)
    {
        this.gameObject = gameObject;
        this.system = this.gameObject.getSystem();

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

    public function isRelated(gameObject:GameObject):Bool
    {
        return this.gameObject == gameObject;
    }

    public function roll(action:IAction):Void
    {
        system.events.post(new ActionPreRollEvent(action, this));
        this.response = system.dices.roll(request);
        system.events.post(new ActionPostRollEvent(action, this));
    }

    public function willRoll(roll:ActionPool):Bool
    {
        return this == roll;
    }
}
