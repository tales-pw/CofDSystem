package pw.tales.cofdsystem.character.traits.merits.ambidextrous;

import pw.tales.cofdsystem.action.events.OffhandModiferEvent;
import pw.tales.cofdsystem.character.traits.merits.Merit;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

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
