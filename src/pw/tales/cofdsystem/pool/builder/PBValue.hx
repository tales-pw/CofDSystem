package pw.tales.cofdsystem.pool.builder;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;
import pw.tales.cofdsystem.utils.math.MathValue;

@:expose("PBValue")
class PBValue extends PoolBuilder
{
    private final value:Int;

    public function new(value:Int)
    {
        super();
        this.value = value;
    }

    override public function getHumanReadable():String
    {
        return Std.string(this.value);
    }

    override public function build(gameObject:GameObject):IMathOperation<Int>
    {
        return new MathValue(value);
    }
}
