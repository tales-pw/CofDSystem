package pw.tales.cofdsystem.pool.builder;

import pw.tales.cofdsystem.utils.math.MathValue;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;
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

    private function getTraitValue(gameObject:GameObject):Int
    {
        var trait:Null<Trait> = gameObject.getTrait(this.traitType);

        if (trait == null)
            return 0;

        return trait.getValue();
    }

    override public function build(gameObject:GameObject):IMathOperation<Int>
    {
        var value = this.getTraitValue(gameObject);
        return new MathValue(value);
    }
}
