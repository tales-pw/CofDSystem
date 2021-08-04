package pw.tales.cofdsystem.action.events;

import pw.tales.cofdsystem.action.IAction;
import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;

interface IActionEvent extends IGameObjectEvent
{
    public function getAction():IAction;

    function isRelatedAction(action:IAction):Bool;
}
