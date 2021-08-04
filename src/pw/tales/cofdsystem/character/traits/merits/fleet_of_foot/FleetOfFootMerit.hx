package pw.tales.cofdsystem.character.traits.merits.fleet_of_foot;

import pw.tales.cofdsystem.character.traits.advantages.SpeedAdvantage;
import pw.tales.cofdsystem.character.traits.merits.Merit;
import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("SmallFramedMerit")
class FleetOfFootMerit extends Merit
{
    public static final TYPE:FleetOfFootType = new FleetOfFootType("Fleet_of_Foot");

    public function new(dn:String, gameObject:GameObject, ?customName:String)
    {
        super(dn, gameObject, TYPE, customName);
        this.eventBus.addHandler(AdvantageModEvent, this.onAdvantageModEvent, HandlerPriority.NORMAL);
    }

    private function onAdvantageModEvent(event:AdvantageModEvent)
    {
        if (event.getAdvantage().getType() != SpeedAdvantage.TYPE)
            return;
        event.apply(this.getValue());
    }
}
