package pw.tales.cofdsystem.game_object.traits.value_trait.events;

import pw.tales.cofdsystem.game_object.events.traits.TraitEvent;

class TraitLimitEvent extends TraitEvent
{
    private var traitLimit = 5;

    public function new(trait:Trait)
    {
        super(trait);
    }

    public function getTraitLimit():Int
    {
        return this.traitLimit;
    }

    public function setTraitLimit(traitLimit:Int):Void
    {
        this.traitLimit = traitLimit;
    }
}
