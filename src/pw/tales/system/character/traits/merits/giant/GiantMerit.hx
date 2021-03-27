package pw.tales.system.character.traits.merits.giant;

import pw.tales.system.character.traits.advantages.SizeAdvantage;
import pw.tales.system.character.traits.merits.Merit;
import pw.tales.system.game_object.events.AdvantageModEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.events.HandlerPriority;

@:keep
@autoregister
@:expose("GiantMerit")
class GiantMerit extends Merit {
    public static final TYPE:GiantMeritType = new GiantMeritType("Giant");

    public function new(dn:String, gameObject:GameObject, ?customName:String) {
        super(dn, gameObject, TYPE, customName);
        this.eventBus.addHandler(AdvantageModEvent, this.onAdvantageModEvent, HandlerPriority.NORMAL);
    }

    private function onAdvantageModEvent(event:AdvantageModEvent) {
        if (event.getAdvantage().getType() != SizeAdvantage.TYPE) return;
        event.apply(1);
    }
}
