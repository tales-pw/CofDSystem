package pw.tales.system.utils.math;

class MathSubtraction extends MathBinaryOperation<Int> {
    override public function calculate():Int {
        return this.operand1.calculate() - this.operand2.calculate();
    }
}
