package pw.tales.cofdsystem.utils.events;

interface IEventBus {
    function createSubBus():SubEventBus;

    function post<T: IEvent>(event:T):Void;

    function addHandler<T: IEvent>(type:Class<T>, handler:(T) -> Void, priority:Int = null):EventHandlerRecord<T>;

    function addHandlerRecord<T: IEvent>(record:EventHandlerRecord<T>):Void;

    function removeHandlerRecord<T: IEvent>(record:EventHandlerRecord<T>):Void;
}
