package pw.tales.cofdsystem.action.events;

import pw.tales.cofdsystem.game_object.GameObject;

class ActionEvent implements IActionEvent
{
    private var action:IAction;

    public function new(action:IAction)
    {
        this.action = action;
    }

    public function getAction():IAction
    {
        return this.action;
    }

    public function isActor(gameObject:GameObject)
    {
        return action.getOpposition().getActorPool().getGameObject() == gameObject;
    }

    public function isRelatedAction(action:IAction)
    {
        return this.action == action;
    }

    public function isRelated(character:GameObject):Bool
    {
        return action.getOpposition().isRelated(character);
    }
}
