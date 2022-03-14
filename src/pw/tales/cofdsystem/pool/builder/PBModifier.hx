package pw.tales.cofdsystem.pool.builder;

import pw.tales.cofdsystem.utils.math.MathValue;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose("PBModifier")
class PBModifier extends PoolBuilder
{
    private final modifier:IModifier;
    private final value:Int;

    public function new(modifier:IModifier, value:Int)
    {
        super();
        this.modifier = modifier;
        this.value = value;
    }

    override public function getHumanReadable():String
    {
        return this.modifier.getDisplayName();
    }

    override public function build(gameObject:GameObject):IMathOperation<Int>
    {
        return new MathValue(this.value);
    }
}
