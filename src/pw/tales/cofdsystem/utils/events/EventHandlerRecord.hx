package pw.tales.cofdsystem.utils.events;

@:expose("EventHandlerRecord")
class EventHandlerRecord<T:IEvent>
{
    public var type:Class<T>;
    public var handlerFunction:(T) -> Void;
    public var priority:Int;

    public function new(
        type:Class<T>,
        handlerFunction:(T) -> Void,
        priority:Int
    )
    {
        this.type = type;
        this.handlerFunction = handlerFunction;
        this.priority = priority;
    }

    public function toString():String
    {
        var clazz = Type.getClass(this);
        return '${Utility.getClassName(clazz)}[${Utility.getClassName(type)},${priority}]';
    }
}
