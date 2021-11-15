package pw.tales.cofdsystem.character.traits.advantages.willpower.exceptions;

import pw.tales.cofdsystem.game_object.exceptions.TraitException;

@:expose("NoWillpowerException")
class NoWillpowerException extends TraitException
{
    public function new(trait:WillpowerAdvantage)
    {
        super(trait, "No willpower.");
    }
}
