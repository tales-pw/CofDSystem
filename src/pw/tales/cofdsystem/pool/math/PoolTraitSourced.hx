package pw.tales.cofdsystem.pool.math;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose("PoolTraitSourced")
class PoolTraitSourced implements IMathOperation<Int>
{
    private final traitType:TraitType<Dynamic>;
    private final value:Int;

    public function new(
        traitType:TraitType<Dynamic>,
        value:Int
    )
    {
        this.traitType = traitType;
        this.value = value;
    }

    public function getOperands():Array<IMathOperation<Dynamic>>
    {
        return [];
    }

    public function calculate():Int
    {
        return value;
    }
}
