package pw.tales.system.action.events;

import pw.tales.system.common.EnumHand;
import pw.tales.system.game_object.GameObject;

class ActionGetHandEvent extends ActionEvent {
    private var hand:EnumHand = EnumHand.HAND;
    private final gameObject:GameObject;

    public function new(action:IAction, gameObject:GameObject) {
        super(action);
        this.action = action;
        this.gameObject = gameObject;
    }

    public function getGameObject():GameObject {
        return this.gameObject;
    }

    public function setHand(hand:EnumHand) {
        this.hand = hand;
    }

    public function getHand():EnumHand {
        return this.hand;
    }
}
