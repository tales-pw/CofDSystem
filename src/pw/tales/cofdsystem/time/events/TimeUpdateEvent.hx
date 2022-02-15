package pw.tales.cofdsystem.time.events;

import pw.tales.cofdsystem.utils.events.IEvent;

@SuppressWarnings("checkstyle:UnnecessaryConstructor")
class TimeUpdateEvent implements IEvent
{
    public function new() {}

    public static function post(system:CofDSystem):Void
    {
        system.events.post(new TimeUpdateEvent());
    }
}
