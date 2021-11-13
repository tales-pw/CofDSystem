package pw.tales.cofdsystem.utils.math;

@:expose("MathNegation")
class MathNegation extends MathUnaryOperation<Int>
{
    override public function calculate():Int
    {
        return -this.operand.calculate();
    }
}
