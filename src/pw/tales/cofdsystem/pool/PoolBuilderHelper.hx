package pw.tales.cofdsystem.pool;

import pw.tales.cofdsystem.pool.builder.PBMin;
import pw.tales.cofdsystem.pool.builder.PBTrait;
import pw.tales.cofdsystem.pool.builder.PBValue;
import haxe.exceptions.ArgumentException;
import pw.tales.cofdsystem.pool.builder.IPoolBuilder;
import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.pool.builder.PBSum;
import pw.tales.cofdsystem.game_object.traits.TraitType;

function poolBuilder(a:Dynamic):IPoolBuilder
{
    if (Std.isOfType(a, Int))
    {
        return new PBValue(a);
    } else if (Std.isOfType(a, TraitType))
    {
        var traitType = Utility.downcast(a, TraitType);

        @:nullSafety(Off)
        return new PBTrait(traitType);
    } else if (Std.isOfType(a, IPoolBuilder))
    {
        return a;
    }

    throw new ArgumentException("other");
}

function plus(a:Dynamic, b:Dynamic):PBSum
{
    return new PBSum(poolBuilder(a), poolBuilder(b));
}

function min(a:Dynamic, b:Dynamic):PBMin
{
    return new PBMin(poolBuilder(a), poolBuilder(b));
}
