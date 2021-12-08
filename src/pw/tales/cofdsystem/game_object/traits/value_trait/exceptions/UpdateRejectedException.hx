package pw.tales.cofdsystem.game_object.traits.value_trait.exceptions;

import pw.tales.cofdsystem.game_object.exceptions.TraitException;

@:expose("UpdateRejectedException")
class UpdateRejectedException extends TraitException
{
    public function new(trait:ValueTrait, value:Int)
    {
        super(
            trait,
            'Attempt to set ${trait} to ${value} is rejected.'
        );
    }
}
