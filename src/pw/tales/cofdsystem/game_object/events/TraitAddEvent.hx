package pw.tales.cofdsystem.game_object.events;

import pw.tales.cofdsystem.game_object.traits.TraitType;

@:expose("TraitAddEvent")
class TraitAddEvent implements IGameObjectEvent {
    private var gameObject:GameObject;
    private var traitType:TraitType<Dynamic>;
    private var cancelled = false;

    public function new(gameObject:GameObject, trait:TraitType<Dynamic>) {
        this.gameObject = gameObject;
        this.traitType = trait;
    }

    public function setCancelled(cancelled:Bool) {
        this.cancelled = cancelled;
    }

    public function isCancelled():Bool {
        return this.cancelled;
    }

    public function getTraitType():TraitType<Dynamic> {
        return this.traitType;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return this.gameObject == gameObject;
    }
}
