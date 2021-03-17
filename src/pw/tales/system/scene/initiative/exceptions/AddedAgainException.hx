package pw.tales.system.scene.initiative.exceptions;

import pw.tales.system.game_object.GameObject;

class AddedAgainException {
    private final gameObject:GameObject;
    private final turnOrder:Initiative;

    public function new(gameObject:GameObject, turnOrder:Initiative) {
        this.gameObject = gameObject;
        this.turnOrder = turnOrder;
    }
}
