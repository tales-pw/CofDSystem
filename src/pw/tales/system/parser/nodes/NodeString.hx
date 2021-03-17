package pw.tales.system.parser.nodes;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;
import pw.tales.system.utils.math.MathValue;

class NodeString implements INodeCheck {
    private var string:String;

    public function new(string:String) {
        this.string = string;
    }

    public function build(gameObject:GameObject):IMathOperation<Bool> {
        return new MathValue<Bool>(true);
    }

    public function getHumanReadable():String {
        return string;
    }

    public function toString():String {
        return 'NodeString[\"${this.string}\"]';
    }
}
