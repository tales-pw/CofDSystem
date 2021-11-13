package pw.tales.cofdsystem.game_object.traits.advantages;

import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;

@:expose("AdvantageValue")
class AdvantageValue extends Advantage
{
    @Optional
    @Serialize("value")
    private var value:Int;

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>, value:Int)
    {
        super(dn, gameObject, type);
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
