package pw.tales.system.utils.events;

class EventBusTestCase extends haxe.unit.TestCase {
    public function testEvent() {
        var firstTriggered = false;
        var secondTriggered = false;

        var bus = new EventBus();
        bus.addHandler(EventFirst, (v:EventFirst) -> {
            firstTriggered = true;
        }, 1);

        bus.addHandler(EventSecond, (v:EventSecond) -> {
            secondTriggered = true;
        }, 1);

        bus.addHandler(EventSecond, (v:EventSecond) -> {
            assertFalse(secondTriggered);
        }, 0);

        bus.post(new EventFirst());
        bus.post(new EventSecond());

        assertTrue(firstTriggered);
        assertTrue(secondTriggered);
    }

    public function testTreeTriggerEvent() {
        var trigggered:Bool = false;

        var bus = new EventBus();
        bus.addHandler(IEvent, (e:IEvent) -> {
            trigggered = true;
        }, 0);

        bus.post(new EventThird());

        assertTrue(trigggered);
    }

}
