package pw.tales.cofdsystem.pool.builder;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.pool.math.PoolTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose("PBTrait")
class PBTrait extends PoolBuilder
{
    private final traitType:TraitType<Dynamic>;

    public function new(traitType:TraitType<Dynamic>)
    {
        super();
        this.traitType = traitType;
    }

    override public function getHumanReadable():String
    {
        return this.traitType.getDisplayName();
    }

    override public function build(gameObject:GameObject):IMathOperation<Int>
    {
        return new PoolTrait(gameObject, this.traitType);
    }
}
