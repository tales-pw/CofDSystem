package pw.tales.cofdsystem.character.advantages;

import pw.tales.cofdsystem.action.modifications.Willpower;
import datetime.DateTime;
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

    public static function getTimeUpdated(willpower:WillpowerAdvantage):DateTime
    {
        return Reflect.getProperty(willpower, "timeUpdated");
    }

    private static function setTimeUpdated(
        willpower:WillpowerAdvantage,
        newTime:DateTime
    )
    {
        Reflect.setField(willpower, "timeUpdated", newTime);
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
        var timeUpdated = getTimeUpdated(willpower);

        var newTime = timeUpdated + DTPeriod.Hour(2);
        setTimeUpdated(willpower, newTime);

        var data = willpower.serialize();
        willpower.deserialize(data);

        this.assertEquals(newTime, getTimeUpdated(willpower));
    }

    public function testUpdateTimeNotEnoughTime():Void
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = getTimeUpdated(willpower);

        var newTime = timeUpdated + DTPeriod.Hour(2);
        willpower.now = function()
        {
            return newTime;
        };
        system.events.post(new TimeUpdateEvent());

        this.assertEquals(0, willpower.getPoints());
    }

    public function testUpdateTimeSingleInterval():Void
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = getTimeUpdated(willpower);

        var newTime = timeUpdated + WillpowerAdvantage.RESTORE_INTERVAL;
        willpower.now = function()
        {
            return newTime;
        };
        system.events.post(new TimeUpdateEvent());
        this.assertEquals(1, willpower.getPoints());
    }

    public function testUpdateFullInterval():Void
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = getTimeUpdated(willpower);

        var newTime = timeUpdated + WillpowerAdvantage.RESTORE_INTERVAL.multiply(willpower.getValue());
        willpower.now = function()
        {
            return newTime;
        };
        system.events.post(new TimeUpdateEvent());
        this.assertEquals(willpower.getValue(), willpower.getPoints());
    }
}
