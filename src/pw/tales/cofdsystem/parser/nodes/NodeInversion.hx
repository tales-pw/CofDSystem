package pw.tales.cofdsystem.parser.nodes;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;
import pw.tales.cofdsystem.utils.math.MathNegation;

@:expose("NodeInversion")
class NodeInversion implements INodePoolBuilder
{
    private var operand:INodePoolBuilder;

    public function new(operand:INodePoolBuilder)
    {
        this.operand = operand;
    }

    public function build(gameObject:GameObject):IMathOperation<Int>
    {
        return new MathNegation(this.operand.build(gameObject));
    }

    public function getHumanReadable():String
    {
        return '${this.operand.getHumanReadable()}';
    }
}
