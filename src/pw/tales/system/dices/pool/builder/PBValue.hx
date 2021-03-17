package pw.tales.system.dices.pool.builder;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;
import pw.tales.system.utils.math.MathValue;

class PBValue extends PoolBuilder {
    private final value:Int;

    public function new(value:Int) {
        super();
        this.value = value;
    }

    override public function getHumanReadable():String {
        return Std.string(this.value);
    }

    override public function build(gameObject:GameObject):IMathOperation<Int> {
        return new MathValue(value);
    }
}
