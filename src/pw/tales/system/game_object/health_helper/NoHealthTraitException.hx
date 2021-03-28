package pw.tales.system.game_object.health_helper;

import pw.tales.system.game_object.exceptions.GameObjectException;

class NoHealthTraitException extends GameObjectException {
    public function new(gameObject: GameObject) {
        super(gameObject, '${gameObject} have no health trait.');
    }
}
