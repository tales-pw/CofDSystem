package pw.tales.cofdsystem.character.advancement.experience;

import pw.tales.cofdsystem.character.traits.Experience;
import pw.tales.cofdsystem.game_object.events.TraitAddEvent;
import pw.tales.cofdsystem.game_object.events.TraitRemoveEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.GameObjectState;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;
import pw.tales.cofdsystem.utils.Utility;

@:expose("ExpAdvancement")
class ExpAdvancement extends Trait
{
    public static final DN = "experience_advancement";
    public static final TYPE = new ExpAdvancementType(DN);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);

        this.eventBus.addHandler(TraitAddEvent, this.canBeAdded);
        this.eventBus.addHandler(TraitRemoveEvent, this.canBeRemoved);
        this.eventBus.addHandler(ValueTraitUpdateEvent, this.canBeUpdated);
    }

    public function canBeAdded(event:TraitAddEvent)
    {
        if (this.gameObject.getState() != GameObjectState.ACTIVE)
            return;

        var advanceableType:Null<IAdvanceableType> = Utility.downcast(event.getTraitType(), IAdvanceableType);
        if (advanceableType == null)
            return event.setCancelled(true);

        // Get cost
        var cost = advanceableType.getCreateCost();
        if (cost == null)
            return event.setCancelled(true);

        // Spend experience
        var experience:Null<Experience> = this.gameObject.getTrait(Experience.TYPE);
        if (experience == null)
            return event.setCancelled(true);
        if (!experience.isEnough(cost))
            return event.setCancelled(true);

        experience.spend(cost);
    }

    public function canBeUpdated(event:ValueTraitUpdateEvent)
    {
        if (this.gameObject.getState() != GameObjectState.ACTIVE)
            return;

        var advanceableTrait:Null<IAdvanceableTrait> = Utility.downcast(event.getTrait(), IAdvanceableTrait);
        if (advanceableTrait == null)
            return event.setCancelled(true);

        // Disallow lowering stats
        if (event.getTrait().getValue() <= event.getNewValue())
            return event.setCancelled(true);

        // Get cost
        var cost = advanceableTrait.getCost(event.getNewValue());
        if (cost == null)
            return event.setCancelled(true);

        // Spend experience
        var experience:Null<Experience> = this.gameObject.getTrait(Experience.TYPE);
        if (experience == null)
            return event.setCancelled(true);
        if (!experience.isEnough(cost))
            return event.setCancelled(true);

        experience.spend(cost);
    }

    public function canBeRemoved(event:TraitRemoveEvent)
    {
        if (this.gameObject.getState() != GameObjectState.ACTIVE)
            return;
        event.setCancelled(true);
    }
}
