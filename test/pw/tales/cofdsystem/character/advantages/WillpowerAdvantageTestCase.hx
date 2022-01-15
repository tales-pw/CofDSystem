package pw.tales.cofdsystem.character.advantages;

import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import thx.Time;

using pw.tales.cofdsystem.utils.time.TimeUtils;

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

    private function setUpUpdateTimeTest()
    {
        c2.getTrait(WillpowerAdvantage.TYPE).gEventBus.disable();
        c3.getTrait(WillpowerAdvantage.TYPE).gEventBus.disable();

        c1.getTrait(Attributes.RESOLVE).setValue(5);
        c1.getTrait(Attributes.COMPOSURE).setValue(5);

        var willpower = c1.getTrait(WillpowerAdvantage.TYPE);
        willpower.burnWillpower(willpower.getPoints());
        this.assertEquals(0, willpower.getPoints());
        return willpower;
    }

    public function testUpdateTimeNotEnoughTime()
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = willpower.getTimeUpdated();

        var newTime = timeUpdated + Time.fromHours(2);
        system.events.post(new TimeUpdateEvent(newTime));

        this.assertEquals(0, willpower.getPoints());
    }

    public function testUpdateTimeSingleInterval()
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = willpower.getTimeUpdated();

        var newTime = timeUpdated + WillpowerAdvantage.RESTORE_INTERVAL;
        system.events.post(new TimeUpdateEvent(newTime));
        this.assertEquals(1, willpower.getPoints());
    }

    public function testUpdateFullInterval()
    {
        var willpower = this.setUpUpdateTimeTest();
        var timeUpdated = willpower.getTimeUpdated();

        var newTime = timeUpdated + WillpowerAdvantage.RESTORE_INTERVAL.multiply(willpower.getValue());
        system.events.post(new TimeUpdateEvent(newTime));
        this.assertEquals(willpower.getValue(), willpower.getPoints());
    }
}
