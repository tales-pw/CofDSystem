package pw.tales.cofdsystem.pool.builder;

import haxe.exceptions.ArgumentException;
import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.math.MathMin;

@:expose("PBMin")
class PBMin extends PBBinary
{
    public function new(operand1:IPoolBuilder, operand2:IPoolBuilder)
    {
        super(MathMin.new, operand1, operand2);
    }

    override public function getHumanReadable():String
    {
        return 'min(${this.operand1.getHumanReadable()}, ${this.operand2.getHumanReadable()})';
    }

    public static function min<T:Dynamic>(v1:T, v2:T):PBMin
    {
        var operand1:IPoolBuilder;
        var operand2:IPoolBuilder;

        @:nullSafety(Off)
        if (Std.isOfType(v1, TraitType))
        {
            var traitType1 = Utility.downcast(v1, TraitType);
            var traitType2 = Utility.downcast(v2, TraitType);

            operand1 = traitType1.poolBuilder();
            operand2 = traitType2.poolBuilder();
        } else if (Std.isOfType(v1, IPoolBuilder))
        {
            operand1 = cast v1;
            operand2 = cast v2;
        } else
        {
            throw new ArgumentException("v1, v2");
        }

        return new PBMin(operand1, operand2);
    }
}
