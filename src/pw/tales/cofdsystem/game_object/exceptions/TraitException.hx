package pw.tales.cofdsystem.game_object.exceptions;

import pw.tales.cofdsystem.game_object.traits.Trait;

class TraitException extends GameObjectException {
    private final trait:Trait;

    public function new(trait:Trait, msg: String, ?previous:haxe.Exception) {
        super(trait.getGameObject(), msg, previous);
        this.trait = trait;
    }
}
