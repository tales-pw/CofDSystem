package pw.tales.cofdsystem.utils.math;

@:expose("MathSubtraction")
class MathSubtraction extends MathBinaryOperation<Int>
{
    override public function calculate():Int
    {
        return this.operand1.calculate() - this.operand2.calculate();
    }
}
