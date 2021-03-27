package pw.tales.system.character.traits.merits.ambidextrous;

import pw.tales.system.action.events.OffhandModiferEvent;
import pw.tales.system.character.traits.merits.Merit;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("AmbidextrousMerit")
class AmbidextrousMerit extends Merit {
    public static final TYPE:AmbidextrousMeritType = new AmbidextrousMeritType("Ambidextrous");

    public function new(dn:String, gameObject:GameObject, ?customName:String) {
        super(dn, gameObject, TYPE, customName);
        this.eventBus.addHandler(OffhandModiferEvent, this.onOffhandModifer, HandlerPriority.NORMAL);
    }

    private function onOffhandModifer(event:OffhandModiferEvent) {
        event.setModifer(0);
    }
}
