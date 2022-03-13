package pw.tales.cofdsystem.game_object.traits.value_trait;

import pw.tales.cofdsystem.game_object.traits.value_trait.events.TraitLimitEvent;
import pw.tales.cofdsystem.character.advancement.experience.IAdvanceableTrait;
import pw.tales.cofdsystem.game_object.traits.value_trait.exceptions.UpdateRejectedException;
import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;

@:expose("ValueTrait")
class ValueTrait extends Trait implements IAdvanceableTrait
{
    @Serialize("value")
    private var value:Int;

    private var valueType:ValueTraitType<Dynamic>;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:ValueTraitType<Dynamic>,
        defaultValue:Int
    )
    {
        super(dn, gameObject, type);
        this.value = defaultValue;
        this.valueType = type;
    }

    public function getTraitLimit():Int
    {
        var event = new TraitLimitEvent(this);
        this.eventBus.post(event);
        return event.getTraitLimit();
    }

    override public function getValue():Int
    {
        return this.value;
    }

    public function canUpdate(newValue:Int):Bool
    {
        var event = new ValueTraitUpdateEvent(this, newValue);
        this.system.events.post(event);

        if (event.isCancelled())
            return false;

        var traitLimit = this.getTraitLimit();

        if (newValue > traitLimit)
            return false;

        return true;
    }

    public function getCost(newValue:Int):Null<Int>
    {
        var dotCost = this.valueType.getDotCost();
        if (dotCost == null)
            return null;
        return (newValue - this.getValue()) * dotCost;
    }

    public function setValue(value:Int):Void
    {
        if (!this.canUpdate(value))
            throw new UpdateRejectedException(this, value);

        this.value = value;
        this.notifyUpdated();
    }
}
