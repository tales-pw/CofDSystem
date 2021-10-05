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

    public function isActor(gameObject:GameObject):Bool
    {
        return this.action.getActor() == gameObject;
    }

    public function isRelatedAction(action:IAction):Bool
    {
        return this.action == action;
    }

    public function isRelated(gameObject:GameObject):Bool
    {
        return this.action.isRelated(gameObject);
    }
}
