package pw.tales.system.game_object.exceptions;

import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.Utility;

@:keep
@:expose("MITraitAddException")
class MITraitAddException {
    private final type:TraitType<Dynamic>;

    public function new(type:TraitType<Dynamic>) {
        this.type = type;
    }

    public function toString() {
        var className = Utility.getClassName(Type.getClass(this));
        return '${className}[${this.type}]';
    }
}
