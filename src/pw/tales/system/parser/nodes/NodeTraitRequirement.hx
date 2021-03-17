package pw.tales.system.parser.nodes;

import pw.tales.system.dices.pool.math.PoolTrait;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;
import pw.tales.system.utils.math.MathMore;
import pw.tales.system.utils.math.MathValue;

class NodeTraitRequirement implements INodeCheck {
    private var trait:NodeTrait;
    private var value:NodeDots;

    public function new(trait:NodeTrait, value:NodeDots) {
        this.trait = trait;
        this.value = value;
    }

    public function getHumanReadable():String {
        return '${trait.getHumanReadable()} ${value.getHumanReadable()}';
    }

    public function build(gameObject:GameObject):IMathOperation<Bool> {
        return new MathMore(
        new PoolTrait(gameObject, this.trait.getValue()),
        new MathValue<Int>(this.value.getValue() - 1)
        );
    }

    public function toString():String {
        return 'NodeTraitRequirement[trait=${this.trait},value=${this.value}]';
    }
}
