package pw.tales.cofdsystem.pool.builder;

using pw.tales.cofdsystem.pool.PoolBuilderHelper;

import pw.tales.cofdsystem.utils.math.MathMin;

@:expose("PBMin")
class PBMin extends PBBinary
{
    public function new(operand1:IPoolBuilder, operand2:IPoolBuilder)
    {
        super(MathMin.new, operand1, operand2);
    }

    override public function getHumanReadable():String
    {
        return 'min(${this.operand1.getHumanReadable()}, ${this.operand2.getHumanReadable()})';
    }

    public static function min<T:Dynamic>(v1:T, v2:T):PBMin
    {
        var operand1 = v1.poolBuilder();
        var operand2 = v2.poolBuilder();
        return new PBMin(operand1, operand2);
    }
}
