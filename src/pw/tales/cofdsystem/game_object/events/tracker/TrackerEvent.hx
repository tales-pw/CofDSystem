package pw.tales.cofdsystem.game_object.events.tracker;

@:expose("TrackerEvent")
class TrackerEvent extends GameObjectEvent {
    private final tracker:TraitTracker;

    public function new(tracker:TraitTracker) {
        super(tracker.getGameObject());
        this.tracker = tracker;
    }

    public function getTracker():TraitTracker {
        return this.tracker;
    }
}
