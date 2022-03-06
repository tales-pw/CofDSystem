package pw.tales.cofdsystem.pool.builder;

import haxe.exceptions.ArgumentException;
import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

/*

 */
@:expose("PoolBuilder")
class PoolBuilder implements IPoolBuilder
{
    public function new() {}

    public function getHumanReadable():String
    {
        throw "Unimplemented";
    }

    public function build(gameObject:GameObject):IMathOperation<Int>
    {
        throw "Unimplemented";
    }

    public function plus(other:Dynamic):PBSum
    {
        var otherPoolBuilder:IPoolBuilder;

        if (Std.isOfType(other, Int))
        {
            otherPoolBuilder = new PBValue(other);
        } else if (Std.isOfType(other, TraitType))
        {
            var traitType = Utility.downcast(other, TraitType);

            @:nullSafety(Off)
            otherPoolBuilder = traitType.poolBuilder();
        } else if (Std.isOfType(other, IPoolBuilder))
        {
            otherPoolBuilder = other;
        } else
        {
            throw new ArgumentException("other");
        }

        return new PBSum(this, otherPoolBuilder);
    }
}
