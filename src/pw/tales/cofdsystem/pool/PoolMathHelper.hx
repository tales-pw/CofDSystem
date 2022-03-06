package pw.tales.cofdsystem.pool;

import pw.tales.cofdsystem.pool.math.PoolTrait;
import pw.tales.cofdsystem.pool.math.PoolModifier;
import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.math.IMathOperation;

function replace(
    pool:IMathOperation<Dynamic>,
    replaceWhat:TraitType<Dynamic>,
    replaceWith:TraitType<Dynamic>
):Void
{
    var traits = searchTraits(pool, replaceWhat);
    for (trait in traits)
    {
        trait.setTraitType(replaceWith);
    }
}

function searchTraits(
    pool:IMathOperation<Dynamic>,
    traitType:TraitType<Dynamic>
):Array<PoolTrait>
{
    return getTraits(pool).filter(
        (trait) -> trait.getTraitType() == traitType
    );
}

function getTraits(pool:IMathOperation<Dynamic>):Array<PoolTrait>
{
    var trait = Utility.downcast(pool, PoolTrait);

    if (trait != null)
        return [trait];

    var traits = [];
    var operands = pool.getOperands();
    for (operand in operands)
    {
        var newTraits = getTraits(operand);
        traits = traits.concat(newTraits);
    }

    return traits;
}

function getModifier(
    pool:IMathOperation<Dynamic>,
    modifier:IModifer
):Null<PoolModifier>
{
    var poolMod = Utility.downcast(pool, PoolModifier);

    if (poolMod != null && poolMod.getModifier() == modifier)
        return poolMod;

    var operands = pool.getOperands();
    for (operand in operands)
    {
        var operandPoolMod = getModifier(operand, modifier);
        if (operandPoolMod != null)
            return operandPoolMod;
    }

    return null;
}
