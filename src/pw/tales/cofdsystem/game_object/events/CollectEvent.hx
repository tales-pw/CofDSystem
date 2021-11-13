package pw.tales.cofdsystem.game_object.events;

@:expose("CollectEvent<T>")
class CollectEvent<T> extends GameObjectEvent
{
    private final collected:Array<T> = [];

    public function collect(aspiration:T):Void
    {
        this.collected.push(aspiration);
    }

    public function getCollected():Array<T>
    {
        return this.collected;
    }
}
