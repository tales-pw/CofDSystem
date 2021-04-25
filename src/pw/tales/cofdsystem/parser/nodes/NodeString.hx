package pw.tales.cofdsystem.parser.nodes;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;
import pw.tales.cofdsystem.utils.math.MathValue;

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
