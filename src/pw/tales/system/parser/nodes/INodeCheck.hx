package pw.tales.system.parser.nodes;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;

@:keep
@:expose
interface INodeCheck extends INode {
    function build(gameObject:GameObject):IMathOperation<Bool>;
}
