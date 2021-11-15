package pw.tales.cofdsystem.utils.math;

@:expose("MathOr")
class MathOr extends MathBinaryOperation<Bool>
{
    override public function calculate():Bool
    {
        return this.operand1.calculate() || this.operand2.calculate();
    }
}
