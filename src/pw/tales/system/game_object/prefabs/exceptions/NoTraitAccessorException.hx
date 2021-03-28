package pw.tales.system.game_object.prefabs.exceptions;

import pw.tales.system.game_object.traits.TraitType;

class NoTraitAccessorException extends AccessorException {
    public function new(gameObject: GameObject, type: TraitType<Dynamic>) {
        super(gameObject, '${gameObject} doesn\'t have any traits of type: ${type}');
    }
}
