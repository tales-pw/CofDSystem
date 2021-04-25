package pw.tales.cofdsystem.utils.math;

class MathNegation extends MathUnaryOperation<Int> {
    override public function calculate():Int {
        return -this.operand.calculate();
    }
}