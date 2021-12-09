package pw.tales.cofdsystem.character.advancement.experience;

import pw.tales.cofdsystem.character.advancement.core.AdvancementTrait;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.character.traits.Experience;
import pw.tales.cofdsystem.game_object.events.TraitAddEvent;
import pw.tales.cofdsystem.game_object.events.TraitRemoveEvent;
import pw.tales.cofdsystem.game_object.GameObjectState;
import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;
import pw.tales.cofdsystem.utils.Utility;

@:expose("ExpAdvancement")
class ExpAdvancement extends AdvancementTrait
{
    public static final DN = "experience_advancement";
    public static final TYPE = TraitType.createType(DN, ExpAdvancement.new);

    public override function canBeAdded(event:TraitAddEvent):Void
    {
        if (this.disabled)
            return;

        if (this.gameObject.getState() != GameObjectState.ACTIVE)
            return;

        var advanceableType = Utility.downcast(event.getTraitType(), IAdvanceableType);
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

    public override function canBeUpdated(event:ValueTraitUpdateEvent):Void
    {
        if (this.disabled)
            return;

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

    public override function canBeRemoved(event:TraitRemoveEvent):Void
    {
        if (this.disabled)
            return;

        if (this.gameObject.getState() != GameObjectState.ACTIVE)
            return;

        if (event.getTrait().version != NEW)
            event.setCancelled(true);
    }
}
