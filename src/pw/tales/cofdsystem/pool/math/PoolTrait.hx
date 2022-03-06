package pw.tales.cofdsystem.pool.math;

import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose("PoolTrait")
class PoolTrait implements IMathOperation<Int>
{
    private final gameObject:GameObject;
    private final traitType:TraitType<Dynamic>;

    public function new(gameObject:GameObject, traitType:TraitType<Dynamic>)
    {
        this.gameObject = gameObject;
        this.traitType = traitType;
    }

    public function getOperands():Array<IMathOperation<Dynamic>>
    {
        return [];
    }

    public function calculate():Int
    {
        var trait:Null<Trait> = this.gameObject.getTrait(this.traitType);
        if (trait == null)
            return 0;
        return trait.getValue();
    }
}
