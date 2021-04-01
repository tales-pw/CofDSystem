package pw.tales.system.game_object.trait_manager.exceptions;

import pw.tales.system.game_object.exceptions.TraitException;
import pw.tales.system.game_object.traits.Trait;

@:expose("CreationRejectedException")
class RemoveRejectedException extends TraitException {
    public function new(trait:Trait) {
        super(trait, 'Attempt to remove ${trait} is rejected.');
    }
}
