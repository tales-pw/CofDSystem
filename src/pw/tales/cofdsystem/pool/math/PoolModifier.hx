package pw.tales.cofdsystem.pool.math;

import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose("PoolModifier")
class PoolModifier implements IMathOperation<Int>
{
    private final modifier:IModifier;

    private var restrctied:Bool = false;
    private var value:Int;

    public function new(modifier:IModifier, value:Int)
    {
        this.modifier = modifier;
        this.value = value;
    }

    public function setRestrctied(restrctied:Bool):Void
    {
        this.restrctied = restrctied;
    }

    public function add(addMod:Int):Void
    {
        this.value += addMod;
    }

    public function getModifier():IModifier
    {
        return this.modifier;
    }

    public function getOperands():Array<IMathOperation<Dynamic>>
    {
        return [];
    }

    public function calculate():Int
    {
        if (this.restrctied && this.value > 5)
        {
            return 5;
        }

        return this.value;
    }
}
