package pw.tales.cofdsystem.utils.math;

@:expose("MathValue<T:Dynamic>")
class MathValue<T:Dynamic> implements IMathOperation<T>
{
    private var value:T;

    public function new(value:T)
    {
        this.value = value;
    }

    public function getValue():T
    {
        return this.value;
    }

    public function setValue(value:T)
    {
        this.value = value;
    }

    public function getOperands():Array<IMathOperation<Dynamic>>
    {
        return [];
    }

    public function calculate():T
    {
        return this.value;
    }
}
