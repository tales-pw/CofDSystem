package pw.tales.cofdsystem.pool;

import pw.tales.cofdsystem.pool.math.PoolTrait;
import pw.tales.cofdsystem.pool.math.PoolTraitSourced;
import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.math.IMathOperation;

function replace(
    pool:IMathOperation<Dynamic>,
    replaceWhat:TraitType<Dynamic>,
    replaceWith:TraitType<Dynamic>
):Void
{
    var traits = getTraits(pool, replaceWhat);
    for (trait in traits)
    {
        trait.setTraitType(replaceWith);
    }
}

function getTraits(
    pool:IMathOperation<Dynamic>,
    traitType:TraitType<Dynamic>
):Array<PoolTrait>
{
    var trait = Utility.downcast(pool, PoolTrait);

    if (trait != null && trait.getTraitType() == traitType)
        return [trait];

    var traits = [];
    var operands = pool.getOperands();
    for (operand in operands)
    {
        var newTraits = getTraits(operand, traitType);
        traits = traits.concat(newTraits);
    }

    return traits;
}

function getModifier(
    pool:IMathOperation<Dynamic>,
    traitType:TraitType<Dynamic>
):Null<PoolTraitSourced>
{
    var sourced = Utility.downcast(pool, PoolTraitSourced);

    if (sourced != null && sourced.getTraitType() == traitType)
        return sourced;

    // Get in operands
    var operands = pool.getOperands();
    for (operand in operands)
    {
        var operandModifer = getModifier(operand, traitType);
        if (operandModifer != null)
            return operandModifer;
    }

    return null;
}
