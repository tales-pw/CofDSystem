package pw.tales.system.game_object.traits.value_trait.events;

import pw.tales.system.game_object.events.traits.TraitPreUpdateEvent;

class ValueTraitUpdateEvent extends TraitPreUpdateEvent {
    private final newValue:Int;

    public function new(trait:Trait, newValue:Int) {
        super(trait);
        this.newValue = newValue;
    }

    public function getNewValue():Int {
        return this.newValue;
    }
}
