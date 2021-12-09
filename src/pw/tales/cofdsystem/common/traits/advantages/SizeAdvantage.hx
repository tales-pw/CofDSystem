package pw.tales.cofdsystem.common.traits.advantages;

import pw.tales.cofdsystem.utils.events.IEvent;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTraitType;
import pw.tales.cofdsystem.game_object.events.TraitModEvent;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTrait;
import pw.tales.cofdsystem.game_object.GameObject;

@RegisterTraitTypes
@:expose("SizeAdvantage")
class SizeAdvantage extends ValueTrait implements IAdvantage
{
    public static final DN = "Размер";
    public static final TYPE = ValueTraitType.createType(DN, SizeAdvantage.new);
    public static final DEFAULT = 5;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:ValueTraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, DEFAULT);
    }

    override public function getValue():Int
    {
        var event = new TraitModEvent(gameObject, this);
        this.eventBus.post(event);
        return this.value + event.getModifier();
    }

    public override function shouldUpdateView(event:IEvent):Bool
    {
        return true;
    }
}
