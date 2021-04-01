package pw.tales.system.game_object.trait_manager.exceptions;

import pw.tales.system.game_object.exceptions.GameObjectException;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

@:expose("CreationRejectedException")
class CreationRejectedException extends GameObjectException {
    public function new(gameObject: GameObject, type:TraitType<Dynamic>) {
        super(gameObject, 'Attempt to create ${type} for ${gameObject} is rejected.');
    }
}
