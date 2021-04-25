package pw.tales.cofdsystem.game_object.events.traits;

import pw.tales.cofdsystem.game_object.traits.Trait;

@:expose("TraitEvent")
class TraitEvent implements IGameObjectEvent {
    private var trait:Trait;

    public function new(trait:Trait) {
        this.trait = trait;
    }

    public function getTrait():Trait {
        return this.trait;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return this.trait.getGameObject() == gameObject;
    }
}
