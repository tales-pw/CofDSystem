package pw.tales.system.game_object.exceptions;

import pw.tales.system.game_object.traits.TraitType;

@:expose("CreationRejectedException")
class CreationRejectedException {
    public function new(type:TraitType<Dynamic>) {
    }
}
