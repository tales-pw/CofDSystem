package pw.tales.system.action.events;

import pw.tales.system.game_object.GameObject;

class ActionEvent implements IActionEvent {
    private var action:IAction;
    private var system:CofDSystem;

    public function new(action:IAction, system:CofDSystem) {
        this.action = action;
        this.system = system;
    }

    public function getAction():IAction {
        return this.action;
    }

    public function getSystem():CofDSystem {
        return this.system;
    }

    public function isActor(gameObject:GameObject) {
        return action.getOpposition().getActorPool().getGameObject() == gameObject;
    }

    public function isRelated(character:GameObject):Bool {
        return action.getOpposition().isRelated(character);
    }
}
