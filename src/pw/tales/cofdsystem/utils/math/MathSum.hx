package pw.tales.cofdsystem.utils.math;

@:expose("MathSum")
class MathSum extends MathBinaryOperation<Int>
{
    override public function calculate():Int
    {
        return this.operand1.calculate() + this.operand2.calculate();
    }
}
