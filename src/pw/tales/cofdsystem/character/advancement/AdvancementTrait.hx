package pw.tales.cofdsystem.character.advancement;

import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;
import pw.tales.cofdsystem.game_object.events.TraitRemoveEvent;
import pw.tales.cofdsystem.game_object.events.TraitAddEvent;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;

class AdvancementTrait extends Trait
{
    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);

        this.eventBus.addHandler(TraitAddEvent, this.canBeAdded);
        this.eventBus.addHandler(TraitRemoveEvent, this.canBeRemoved);
        this.eventBus.addHandler(ValueTraitUpdateEvent, this.canBeUpdated);
    }

    public function canBeAdded(event:TraitAddEvent):Void {}

    public function canBeUpdated(event:ValueTraitUpdateEvent):Void {}

    public function canBeRemoved(event:TraitRemoveEvent):Void {}
}
