package pw.tales.system.game_object.events.tracker;

@:expose("TrackerEvent")
class TrackerEvent implements IGameObjectEvent {
    private final tracker:TraitTracker;

    public function new(tracker:TraitTracker) {
        this.tracker = tracker;
    }

    public function getTracker():TraitTracker {
        return this.tracker;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return tracker.getGameObject() == gameObject;
    }
}
