package pw.tales.system.game_object.exceptions;

import pw.tales.system.exceptions.CofDSystemException;

class GameObjectException extends CofDSystemException {
    private final gameObject: GameObject;

    public function new(gameObject: GameObject, msg: String, ?previous:haxe.Exception) {
        super(msg, previous);
        this.gameObject = gameObject;
    }
}
