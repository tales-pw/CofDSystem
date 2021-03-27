package pw.tales.system.game_object.exceptions;

import pw.tales.system.game_object.traits.Trait;

@:expose("CreationRejectedException")
class RemoveRejectedException {
    public function new(trait:Trait) {
    }
}
