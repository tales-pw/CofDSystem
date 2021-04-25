package pw.tales.cofdsystem.parser.nodes;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;
import pw.tales.cofdsystem.utils.math.MathOr;

class NodeOr implements INodeCheck {
    private var node1:INodeCheck;
    private var node2:INodeCheck;
    private var separator:String;

    public function new(node1:INodeCheck, node2:INodeCheck, separator = " или ") {
        this.node1 = node1;
        this.node2 = node2;
        this.separator = separator;
    }

    public function getHumanReadable():String {
        return '${this.node1.getHumanReadable()}${this.separator}${this.node2.getHumanReadable()}';
    }

    public function build(gameObject:GameObject):IMathOperation<Bool> {
        return new MathOr(this.node1.build(gameObject), this.node2.build(gameObject));
    }

    public function toString():String {
        return 'NodeOr[${this.node1},${this.node2}]';
    }
}
