package pw.tales.system.parser.nodes;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;
import pw.tales.system.utils.math.MathValue;
import pw.tales.system.utils.Utility;

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
