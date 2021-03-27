package pw.tales.system.game_object.exceptions;

import pw.tales.system.game_object.traits.Trait;

@:expose("UpdateRejectedException")
class UpdateRejectedException {
    public function new(type:Trait, newValue:Int) {
    }
}
