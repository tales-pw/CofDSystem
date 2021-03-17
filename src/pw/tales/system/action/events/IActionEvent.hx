package pw.tales.system.action.events;

import pw.tales.system.action.IAction;
import pw.tales.system.game_object.events.IGameObjectEvent;

interface IActionEvent extends IGameObjectEvent {
    public function getAction():IAction;

    public function getSystem():CofDSystem;
}
