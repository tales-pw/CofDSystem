package pw.tales.cofdsystem.character.traits.merits.ambidextrous;

import pw.tales.cofdsystem.action.events.OffhandModiferEvent;
import pw.tales.cofdsystem.character.traits.merits.Merit;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("AmbidextrousMerit")
class AmbidextrousMerit extends Merit
{
    public static final TYPE:AmbidextrousMeritType = new AmbidextrousMeritType("Ambidextrous");

    public function new(
        dn:String,
        gameObject:GameObject,
        type:MeritType,
        customName:Null<String> = null
    )
    {
        super(dn, gameObject, type, customName);
        this.eventBus.addHandler(
            OffhandModiferEvent,
            this.onOffhandModifer,
            HandlerPriority.NORMAL
        );
    }

    private function onOffhandModifer(event:OffhandModiferEvent):Void
    {
        event.setModifer(0);
    }
}
