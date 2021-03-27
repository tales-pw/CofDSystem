package pw.tales.system.parser.nodes;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;
import pw.tales.system.utils.math.MathValue;

class NodeNumber implements INodePoolBuilder {
    private var number:Int;

    public function new(number:Int) {
        this.number = number;
    }

    public function getHumanReadable():String {
        return Std.string(number);
    }

    public function getValue():Int {
        return number;
    }

    public function build(gameObject:GameObject):IMathOperation<Int> {
        return new MathValue<Int>(number);
    }

    public function toString():String {
        return 'NodeNumber[${this.number}]';
    }
}
