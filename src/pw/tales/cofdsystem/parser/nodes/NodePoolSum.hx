package pw.tales.cofdsystem.parser.nodes;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;
import pw.tales.cofdsystem.utils.math.MathSum;

class NodePoolSum implements INodePoolBuilder
{
    private var left:INodePoolBuilder;
    private var right:INodePoolBuilder;

    public function new(left:INodePoolBuilder, right:INodePoolBuilder)
    {
        this.left = left;
        this.right = right;
    }

    public function build(gameObject:GameObject):IMathOperation<Int>
    {
        return new MathSum(this.left.build(gameObject), this.right.build(gameObject));
    }

    public function getHumanReadable():String
    {
        return '${this.left.getHumanReadable()} + ${this.right.getHumanReadable()}';
    }
}
