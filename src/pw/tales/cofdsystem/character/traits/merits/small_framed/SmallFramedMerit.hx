package pw.tales.cofdsystem.character.traits.merits.small_framed;

import pw.tales.cofdsystem.common.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.game_object.events.TraitModEvent;
import pw.tales.cofdsystem.character.traits.merits.Merit;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("SmallFramedMerit")
class SmallFramedMerit extends Merit
{
    public static final TYPE = new SmallFramedType("Small_Framed");

    public function new(
        dn:String,
        gameObject:GameObject,
        type:MeritType,
        customName:Null<String> = null
    )
    {
        super(dn, gameObject, type, customName);
        this.eventBus.addHandler(
            TraitModEvent,
            this.onModEvent,
            HandlerPriority.NORMAL
        );
    }

    private function onModEvent(event:TraitModEvent):Void
    {
        if (event.getTrait().getType() != SizeAdvantage.TYPE)
            return;

        event.apply(-1);
    }
}
