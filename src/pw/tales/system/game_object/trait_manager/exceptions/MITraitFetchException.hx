package pw.tales.system.game_object.trait_manager.exceptions;

import pw.tales.system.game_object.exceptions.GameObjectException;
import pw.tales.system.game_object.traits.TraitType;

@:expose("MITraitFetchException")
class MITraitFetchException extends GameObjectException {
    public function new(gameObject: GameObject, type:TraitType<Dynamic>) {
        super(gameObject, 'Attempting to get ${type} but it is mutiinstanced and no dn is provided.');
    }
}
