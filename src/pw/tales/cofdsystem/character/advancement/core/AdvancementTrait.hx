package pw.tales.cofdsystem.character.advancement.core;

import pw.tales.cofdsystem.character.advancement.core.events.AdvancementCollectEvent;
import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;
import pw.tales.cofdsystem.game_object.events.TraitRemoveEvent;
import pw.tales.cofdsystem.game_object.events.TraitAddEvent;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;

class AdvancementTrait extends Trait
{
    public var disabled = false;

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

        this.eventBus.addHandler(AdvancementCollectEvent, this.collect);
    }

    public function setDisabled(disabled:Bool):Void
    {
        this.disabled = disabled;
    }

    public function canBeAdded(event:TraitAddEvent):Void {}

    public function canBeUpdated(event:ValueTraitUpdateEvent):Void {}

    public function canBeRemoved(event:TraitRemoveEvent):Void {}

    public static function get(gameObject:GameObject):Null<AdvancementTrait>
    {
        var event = new AdvancementCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        var collected = event.getCollected();

        if (collected.length != 1)
            return null;

        return collected[0];
    }
}
