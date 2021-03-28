package pw.tales.system.game_object.trait_manager.exceptions;

import pw.tales.system.game_object.exceptions.GameObjectException;
import pw.tales.system.game_object.traits.TraitType;

@:expose("MITraitAddException")
class MITraitAddException  extends GameObjectException {
    public function new(gameObject: GameObject, type:TraitType<Dynamic>) {
        super(gameObject, 'Attempting to add ${type} but it is not mutiinstanced and already exist.');
    }
}
