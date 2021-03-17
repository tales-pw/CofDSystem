package pw.tales.system.utils.math;

class MathMax extends MathBinaryOperation<Int> {
    override public function calculate():Int {
        return Std.int(Math.max(this.operand1.calculate(), this.operand2.calculate()));
    }
}
