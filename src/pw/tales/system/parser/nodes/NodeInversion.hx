package pw.tales.system.parser.nodes;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;
import pw.tales.system.utils.math.MathNegation;

class NodeInversion implements INodePoolBuilder {
    private var operand:INodePoolBuilder;

    public function new(operand:INodePoolBuilder) {
        this.operand = operand;
    }

    public function build(gameObject:GameObject):IMathOperation<Int> {
        return new MathNegation(this.operand.build(gameObject));
    }

    public function getHumanReadable():String {
        return '${this.operand.getHumanReadable()}';
    }
}
