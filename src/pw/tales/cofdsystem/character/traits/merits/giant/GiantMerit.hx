package pw.tales.cofdsystem.character.traits.merits.giant;

import pw.tales.cofdsystem.game_object.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.character.traits.merits.Merit;
import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("GiantMerit")
class GiantMerit extends Merit
{
    public static final TYPE:GiantMeritType = new GiantMeritType("Giant");

    public function new(dn:String, gameObject:GameObject, type:MeritType, customName:Null<String> = null)
    {
        super(dn, gameObject, type, customName);
        this.eventBus.addHandler(
            AdvantageModEvent,
            this.onAdvantageModEvent,
            HandlerPriority.NORMAL
        );
    }

    private function onAdvantageModEvent(event:AdvantageModEvent):Void
    {
        if (event.getAdvantage().getType() != SizeAdvantage.TYPE)
            return;

        event.apply(1);
    }
}
