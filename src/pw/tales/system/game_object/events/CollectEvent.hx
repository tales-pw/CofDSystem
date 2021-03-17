package pw.tales.system.game_object.events;

class CollectEvent<T> implements IGameObjectEvent {
    private final gameObject:GameObject;
    private final collected:Array<T> = [];

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;
    }

    public function collect(aspiration:T) {
        this.collected.push(aspiration);
    }

    public function getCollected():Array<T> {
        return this.collected;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return this.gameObject == gameObject;
    }
}
