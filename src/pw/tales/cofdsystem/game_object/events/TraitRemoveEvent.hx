package pw.tales.cofdsystem.game_object.events;

import pw.tales.cofdsystem.game_object.traits.Trait;

@:expose("TraitRemoveEvent")
class TraitRemoveEvent extends GameObjectEvent
{
    private var trait:Trait;
    private var cancelled = false;

    public function new(trait:Trait)
    {
        super(trait.getGameObject());
        this.trait = trait;
    }

    public function setCancelled(cancelled:Bool):Void
    {
        this.cancelled = cancelled;
    }

    public function isCancelled():Bool
    {
        return this.cancelled;
    }

    public function getTrait():Trait
    {
        return this.trait;
    }
}
