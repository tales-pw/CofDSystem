package pw.tales.cofdsystem.pool.builder;

import pw.tales.cofdsystem.pool.math.PoolTraitSourced;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose("PBTraitSourced")
class PBTraitSourced extends PoolBuilder
{
    private final traitType:TraitType<Dynamic>;
    private final value:Int;

    public function new(
        traitType:TraitType<Dynamic>,
        value:Int
    )
    {
        super();
        this.traitType = traitType;
        this.value = value;
    }

    override public function getHumanReadable():String
    {
        return this.traitType.getDisplayName();
    }

    override public function build(gameObject:GameObject):IMathOperation<Int>
    {
        return new PoolTraitSourced(this.traitType, this.value);
    }
}
