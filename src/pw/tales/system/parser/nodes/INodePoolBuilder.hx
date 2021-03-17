package pw.tales.system.parser.nodes;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;

interface INodePoolBuilder extends INode {
    function build(gameObject:GameObject):IMathOperation<Int>;
}
