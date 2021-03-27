package pw.tales.system.game_object.events;

import pw.tales.system.game_object.traits.Trait;

@:expose("TraitRemoveEvent")
class TraitRemoveEvent implements IGameObjectEvent {
    private var trait:Trait;
    private var cancelled = false;

    public function new(trait:Trait) {
        this.trait = trait;
    }

    public function setCancelled(cancelled:Bool) {
        this.cancelled = cancelled;
    }

    public function isCancelled():Bool {
        return this.cancelled;
    }

    public function getTrait():Trait {
        return this.trait;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return this.getTrait().getGameObject() == gameObject;
    }
}
