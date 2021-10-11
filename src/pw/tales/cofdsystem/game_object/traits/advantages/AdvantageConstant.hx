package pw.tales.cofdsystem.game_object.traits.advantages;

import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;

class AdvantageConstant extends Advantage
{
    @Serialize("value")
    private var value:Int;

    public function new(gameObject:GameObject, type:TraitType<Dynamic>, value:Int)
    {
        super(gameObject, type);
        this.value = value;
    }

    public function setValue(value:Int):Void
    {
        this.value = value;
        this.notifyUpdated();
    }

    override public function getValue():Int
    {
        var event = new AdvantageModEvent(gameObject, this);
        this.eventBus.post(event);
        return value + event.getModifier();
    }
}
