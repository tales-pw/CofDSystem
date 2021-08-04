package pw.tales.cofdsystem.game_object.events;

class CollectEvent<T> extends GameObjectEvent
{
    private final collected:Array<T> = [];

    public function collect(aspiration:T)
    {
        this.collected.push(aspiration);
    }

    public function getCollected():Array<T>
    {
        return this.collected;
    }
}
