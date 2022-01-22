package pw.tales.cofdsystem.character.advantages;

import datetime.DateTime.DTPeriod;

using pw.tales.cofdsystem.time.TimeUtils;

import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.time.events.TimeUpdateEvent;
import pw.tales.cofdsystem.character.traits.advantages.willpower.WillpowerAdvantage;

class WillpowerAdvantageTestCase extends CofDSystemTestCase
{
    public function testNoWillpower():Void
    {
        var willpower = c2.getTrait(WillpowerAdvantage.TYPE);

        var exceptionHappened = false;
        try
        {
            willpower.burnWillpower(willpower.getPoints() + 1);
        } catch (NoWillpowerException)
        {
            exceptionHappened = true;
        }

        assertTrue(exceptionHappened);
    }

    private function setUpUpdateTimeTest():WillpowerAdvantage
    {
        c1.getTrait(Attributes.RESOLVE).setValue(5);
        c1.getTrait(Attributes.COMPOSURE).setValue(5);

        var willpower = c1.getTrait(WillpowerAdvantage.TYPE);
        willpower.burnWillpower(willpower.getPoints());
        this.assertEquals(0, willpower.getPoints());
        return willpower;
    }

    public function testSerialization():Void
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = willpower.getTimeUpdated();

        var newTime = timeUpdated + DTPeriod.Hour(2);
        willpower.setTimeUpdated(newTime);

        var data = willpower.serialize();
        willpower.deserialize(data);

        this.assertEquals(newTime, willpower.getTimeUpdated());
    }

    public function testUpdateTimeNotEnoughTime():Void
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = willpower.getTimeUpdated();

        var newTime = timeUpdated + DTPeriod.Hour(2);
        system.events.post(new TimeUpdateEvent(newTime));

        this.assertEquals(0, willpower.getPoints());
    }

    public function testUpdateTimeSingleInterval():Void
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = willpower.getTimeUpdated();

        var newTime = timeUpdated + WillpowerAdvantage.RESTORE_INTERVAL;
        system.events.post(new TimeUpdateEvent(newTime));
        this.assertEquals(1, willpower.getPoints());
    }

    public function testUpdateFullInterval():Void
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = willpower.getTimeUpdated();

        var newTime = timeUpdated + WillpowerAdvantage.RESTORE_INTERVAL.multiply(willpower.getValue());
        system.events.post(new TimeUpdateEvent(newTime));
        this.assertEquals(willpower.getValue(), willpower.getPoints());
    }
}
