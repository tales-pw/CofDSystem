package pw.tales.cofdsystem.parser.nodes;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;
import pw.tales.cofdsystem.utils.math.MathMore;
import pw.tales.cofdsystem.utils.math.MathValue;

@:expose("NodeTraitRequirement")
class NodeTraitRequirement implements INodeCheck
{
    private var trait:NodeTrait;
    private var value:NodeDots;

    public function new(trait:NodeTrait, value:NodeDots)
    {
        this.trait = trait;
        this.value = value;
    }

    public function getHumanReadable():String
    {
        return '${trait.getHumanReadable()} ${value.getHumanReadable()}';
    }

    public function build(gameObject:GameObject):IMathOperation<Bool>
    {
        return new MathMore(
            this.trait.build(gameObject),
            new MathValue<Int>(this.value.getValue() - 1)
        );
    }

    public function toString():String
    {
        return 'NodeTraitRequirement[trait=${this.trait},value=${this.value}]';
    }
}
