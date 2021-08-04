package pw.tales.cofdsystem.parser.nodes;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose
interface INodeCheck extends INode
{
    function build(gameObject:GameObject):IMathOperation<Bool>;
}
