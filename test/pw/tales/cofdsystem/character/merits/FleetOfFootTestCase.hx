package pw.tales.cofdsystem.character.merits;

import pw.tales.cofdsystem.character.traits.advantages.SpeedAdvantage;
import pw.tales.cofdsystem.character.traits.merits.fleet_of_foot.FleetOfFootMerit;

class FleetOfFootTestCase extends CofDSystemTestCase
{
    public function testFleetOfFoot():Void
    {
        var manager = c1.getTraitManager();

        var speed:SpeedAdvantage = cast(manager.getTrait(SpeedAdvantage.TYPE));
        var speedValue = speed.getValue();

        var fleetOfFoot:FleetOfFootMerit = cast(manager.addTrait(FleetOfFootMerit.TYPE));
        assertEquals(speedValue + fleetOfFoot.getValue(), speed.getValue());

        fleetOfFoot.setValue(2);
        assertEquals(speedValue + fleetOfFoot.getValue(), speed.getValue());

        fleetOfFoot.setValue(3);
        assertEquals(speedValue + fleetOfFoot.getValue(), speed.getValue());

        manager.removeTrait(fleetOfFoot);
        assertEquals(speedValue, speed.getValue());
    }
}
