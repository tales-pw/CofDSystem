package pw.tales.system.utils.math;

class MathAnd extends MathBinaryOperation<Bool> {
    override public function calculate():Bool {
        return this.operand1.calculate() && this.operand2.calculate();
    }
}
