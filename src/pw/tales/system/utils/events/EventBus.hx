package pw.tales.system.utils.events;

class EventBus implements IEventBus {
    private var handlers:Array<EventHandlerRecord<Dynamic>> = [];

    public function new() {}

    public function createSubBus():SubEventBus {
        return new SubEventBus(this);
    }

    public function post<T: IEvent>(event:T) {
        var filteredHandlers:Array<EventHandlerRecord<Dynamic>> = this.handlers.filter(
            function(value:EventHandlerRecord<Dynamic>) {
                return Std.downcast(event, value.type) != null;
            }
        );

        for (handler in filteredHandlers) {
            handler.handlerFunction(event);
        }
    }

    public function addHandler<T: IEvent>(type:Class<T>, handler:(T) -> Void, priority:Int = null):EventHandlerRecord<T> {
        if (priority == null) priority = HandlerPriority.NORMAL;

        var record = new EventHandlerRecord<T>(type, handler, priority);
        this.addHandlerRecord(record);
        return record;
    }

    public function addHandlerRecord<T: IEvent>(record:EventHandlerRecord<T>) {
        handlers.push(record);
        handlers.sort(function(a:EventHandlerRecord<Dynamic>, b:EventHandlerRecord<Dynamic>) {
            return HandlerPriority.comparator(a.priority, b.priority);
        });
    }

    public function removeHandlerRecord<T: IEvent>(record:EventHandlerRecord<T>) {
        this.handlers.remove(record);
    }
}
