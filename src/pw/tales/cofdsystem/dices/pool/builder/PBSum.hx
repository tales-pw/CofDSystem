package pw.tales.cofdsystem.dices.pool.builder;

import pw.tales.cofdsystem.utils.math.MathSum;

class PBSum extends PBBinary {
    public function new(operand1:IPoolBuilder, operand2:IPoolBuilder) {
        super(MathSum.new, operand1, operand2);
    }

    override public function getHumanReadable():String {
        return '${this.operand1.getHumanReadable()} + ${this.operand2.getHumanReadable()}';
    }
}