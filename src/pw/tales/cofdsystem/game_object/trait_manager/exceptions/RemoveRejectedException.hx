package pw.tales.cofdsystem.game_object.trait_manager.exceptions;

import pw.tales.cofdsystem.game_object.exceptions.TraitException;
import pw.tales.cofdsystem.game_object.traits.Trait;

@:expose("RemoveRejectedException")
class RemoveRejectedException extends TraitException
{
    public function new(trait:Trait)
    {
        super(
            trait,
            'Attempt to remove ${trait} is rejected.'
        );
    }
}
