package pw.tales.system.game_object.exceptions;

import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.Utility;

class WrongTypeException {
    private final trait:Trait;
    private final actual:TraitType<Dynamic>;
    private final expected:TraitType<Dynamic>;

    public function new(trait:Trait, actual:TraitType<Dynamic>, expected:TraitType<Dynamic>) {
        this.trait = trait;
        this.actual = actual;
        this.expected = expected;
    }

    public function toString():String {
        var className = Utility.getClassName(Type.getClass(this));
        return '${className}[trait=${this.trait},expected=${this.expected}},actual=${this.actual}]';
    }
}
