package pw.tales.cofdsystem.time.events;

import thx.DateTime;
import pw.tales.cofdsystem.utils.events.IEvent;

class TimeUpdateEvent implements IEvent
{
    private var time:DateTime;

    public function new(time:DateTime)
    {
        this.time = time;
    }

    public function getTime():DateTime
    {
        return this.time;
    }

    public static function post(system:CofDSystem):Void
    {
        var time = DateTime.nowUtc();
        system.events.post(new TimeUpdateEvent(time));
    }
}
