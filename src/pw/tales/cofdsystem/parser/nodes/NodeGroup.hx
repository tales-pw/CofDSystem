package pw.tales.cofdsystem.parser.nodes;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;
import pw.tales.cofdsystem.utils.math.MathValue;
import pw.tales.cofdsystem.utils.Utility;

class NodeGroup implements INode implements INodeCheck {
    private var node:INode;

    public function new(node:INode) {
        this.node = node;
    }

    public function build(gameObject:GameObject):IMathOperation<Bool> {
        var checkNode:Null<INodeCheck> = Utility.downcast(node, INodeCheck);
        if (checkNode == null) return new MathValue<Bool>(true);
        return checkNode.build(gameObject);
    }

    public function getHumanReadable():String {
        return '(${this.node.getHumanReadable()})';
    }

}
