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
}
