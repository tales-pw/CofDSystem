package pw.tales.cofdsystem.utils.math;

@:expose("MathMin")
class MathMin extends MathBinaryOperation<Int>
{
    override public function calculate():Int
    {
        return cast(Math.min(this.operand1.calculate(), this.operand2.calculate()));
    }
}
