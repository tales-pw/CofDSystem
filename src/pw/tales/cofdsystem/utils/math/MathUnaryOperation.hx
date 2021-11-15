package pw.tales.cofdsystem.utils.math;

@:expose("MathUnaryOperation")
class MathUnaryOperation<T:Dynamic> implements IMathOperation<T>
{
    private var operand:IMathOperation<Int>;

    public function new(operand:IMathOperation<Int>)
    {
        this.operand = operand;
    }

    public function getOperands():Array<IMathOperation<Dynamic>>
    {
        return [this.operand];
    }

    public function calculate():T
    {
        throw "Unimplemented";
    }
}
