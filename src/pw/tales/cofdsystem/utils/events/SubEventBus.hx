package pw.tales.cofdsystem.utils.events;

typedef EventFilter = (event:IEvent) -> Bool

@:nullSafety(Off)
@:expose("SubEventBus")
class SubEventBus implements IEventBus
{
    public static final NO_FILTER:EventFilter = cast((event:IEvent) -> true);

    private final parent:IEventBus;
    private final filter:EventFilter;

    private var enabled:Bool = true;
    private var handlers:Array<EventHandlerRecord<Dynamic>> = [];

    public function new(parent:IEventBus, filter:EventFilter = null)
    {
        this.parent = parent;

        if (filter == null)
            filter = SubEventBus.NO_FILTER;
        this.filter = filter;
    }

    public function createSubBus():SubEventBus
    {
        return new SubEventBus(this);
    }

    public function post<T:IEvent>(event:T):Void
    {
        this.checkEnabled();

        this.parent.post(event);
    }

    public function addHandler<T:IEvent>(type:Class<T>, handler:(T) -> Void, priority:Int = null):EventHandlerRecord<T>
    {
        this.checkEnabled();

        var record = this.parent.addHandler(type, (event:T) ->
        {
            if (this.filter(event))
                handler(event);
        }, priority);

        this.handlers.push(record);

        return record;
    }

    public function addHandlerRecord<T:IEvent>(record:EventHandlerRecord<T>):Void
    {
        this.checkEnabled();

        this.parent.addHandlerRecord(record);
        this.handlers.push(record);
    }

    public function removeHandlerRecord<T:IEvent>(record:EventHandlerRecord<T>):Void
    {
        this.checkEnabled();

        this.parent.removeHandlerRecord(record);
        this.handlers.remove(record);
    }

    public function enable():Void
    {
        this.enabled = true;
        for (record in handlers)
            this.parent.addHandlerRecord(record);
    }

    public function disable():Void
    {
        this.enabled = false;
        for (record in handlers)
            this.parent.removeHandlerRecord(record);
    }

    private function checkEnabled():Void
    {
        if (!this.enabled)
            throw "Attempt to use disabled sub bus.";
    }
}
