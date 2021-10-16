package pw.tales.cofdsystem.character.traits.merits.small_framed;

import pw.tales.cofdsystem.game_object.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.character.traits.merits.Merit;
import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("SmallFramedMerit")
class SmallFramedMerit extends Merit
{
    public static final TYPE = new SmallFramedType("Small_Framed");

    public function new(dn:String, gameObject:GameObject, customName:Null<String> = null)
    {
        super(dn, gameObject, TYPE, customName);
        this.eventBus.addHandler(AdvantageModEvent, this.onAdvantageModEvent, HandlerPriority.NORMAL);
    }

    private function onAdvantageModEvent(event:AdvantageModEvent):Void
    {
        if (event.getAdvantage().getType() != SizeAdvantage.TYPE)
            return;

        event.apply(-1);
    }
}
