package pw.tales.cofdsystem.dices.pool.builder;

import pw.tales.cofdsystem.utils.math.MathMin;

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
