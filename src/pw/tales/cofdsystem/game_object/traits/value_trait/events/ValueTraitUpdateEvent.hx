package pw.tales.cofdsystem.game_object.traits.value_trait.events;

import pw.tales.cofdsystem.game_object.events.traits.TraitPreUpdateEvent;

@:expose("ValueTraitUpdateEvent")
class ValueTraitUpdateEvent extends TraitPreUpdateEvent
{
    private final newValue:Int;

    public function new(trait:Trait, newValue:Int)
    {
        super(trait);
        this.newValue = newValue;
    }

    public function getNewValue():Int
    {
        return this.newValue;
    }
}
