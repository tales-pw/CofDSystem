package pw.tales.cofdsystem.utils.math;

class MathMin extends MathBinaryOperation<Int> {
    override public function calculate():Int {
        return cast(Math.min(this.operand1.calculate(), this.operand2.calculate()));
    }
}
