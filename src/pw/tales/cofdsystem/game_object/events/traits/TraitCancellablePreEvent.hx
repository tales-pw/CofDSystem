package pw.tales.cofdsystem.game_object.events.traits;

@:expose("TraitCancellablePreEvent")
class TraitCancellablePreEvent extends TraitPreEvent
{
    private var cancelled = false;

    public function setCancelled(cancelled:Bool)
    {
        this.cancelled = cancelled;
    }

    public function isCancelled():Bool
    {
        return this.cancelled;
    }
}
