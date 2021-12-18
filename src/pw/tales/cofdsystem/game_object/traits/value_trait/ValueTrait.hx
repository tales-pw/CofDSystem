package pw.tales.cofdsystem.game_object.traits.value_trait;

import pw.tales.cofdsystem.character.advancement.experience.IAdvanceableTrait;
import pw.tales.cofdsystem.game_object.traits.value_trait.exceptions.UpdateRejectedException;
import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;

@:expose("ValueTrait")
class ValueTrait extends Trait implements IAdvanceableTrait
{
    @Serialize("value")
    private var value:Int;

    private var savedValue:Int;

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
        this.savedValue = this.value;
        this.valueType = type;
    }

    override public function getValue():Int
    {
        return this.value;
    }

    public function getSavedValue():Int
    {
        return this.savedValue;
    }

    public function canUpdate(newValue:Int, preview:Bool = true):Bool
    {
        var event = new ValueTraitUpdateEvent(this, newValue, preview);
        this.system.events.post(event);
        return !event.isCancelled();
    }

    public function getCost(newValue:Int):Null<Int>
    {
        return this.calcCost(this.value, newValue);
    }

    public function getWorth():Null<Int>
    {
        throw new haxe.exceptions.NotImplementedException();
    }

    private function calcCost(value:Int, newValue:Int):Null<Int>
    {
        var dotCost = this.valueType.getDotCost();
        if (dotCost == null)
            return null;
        return (newValue - value) * dotCost;
    }

    public function setValue(value:Int):Void
    {
        if (!this.canUpdate(value, false))
            throw new UpdateRejectedException(this, value);

        this.value = value;
        this.notifyUpdated();
    }

    public override function acceptChanges():Void
    {
        super.acceptChanges();
        this.savedValue = this.value;
    }
}
