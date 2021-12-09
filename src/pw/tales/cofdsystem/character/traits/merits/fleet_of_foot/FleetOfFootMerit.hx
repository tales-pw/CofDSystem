package pw.tales.cofdsystem.character.traits.merits.fleet_of_foot;

import pw.tales.cofdsystem.game_object.events.TraitModEvent;
import pw.tales.cofdsystem.character.traits.advantages.SpeedAdvantage;
import pw.tales.cofdsystem.character.traits.merits.Merit;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("FleetOfFootMerit")
class FleetOfFootMerit extends Merit
{
    public static final TYPE:FleetOfFootType = new FleetOfFootType("Fleet_of_Foot");

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
        if (event.getTrait().getType() != SpeedAdvantage.TYPE)
            return;

        event.apply(this.getValue());
    }
}
