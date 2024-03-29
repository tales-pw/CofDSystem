package pw.tales.cofdsystem.utils.events;

import haxe.unit.TestCase;

class EventBusTestCase extends TestCase
{
    public function testEvent():Void
    {
        var firstTriggered = false;
        var secondTriggered = false;

        var bus = new EventBus();
        bus.addHandler(EventFirst, (v:EventFirst) ->
        {
            firstTriggered = true;
        }, 1);

        bus.addHandler(EventSecond, (v:EventSecond) ->
        {
            secondTriggered = true;
        }, 1);

        bus.addHandler(EventSecond, (v:EventSecond) ->
        {
            assertFalse(secondTriggered);
        }, 0);

        bus.post(new EventFirst());
        bus.post(new EventSecond());

        assertTrue(firstTriggered);
        assertTrue(secondTriggered);
    }

    public function testTreeTriggerEvent():Void
    {
        var trigggered:Bool = false;

        var bus = new EventBus();
        bus.addHandler(IEvent, (e:IEvent) ->
        {
            trigggered = true;
        }, 0);

        bus.post(new EventThird());

        assertTrue(trigggered);
    }
}
