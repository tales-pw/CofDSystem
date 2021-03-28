package pw.tales.system.character.traits.advantages.willpower.exceptions;

import pw.tales.system.game_object.exceptions.TraitException;

class NoWillpowerException extends TraitException {
    public function new(trait:WillpowerAdvantage) {
        super(trait, "No willpower.");
    }
}
