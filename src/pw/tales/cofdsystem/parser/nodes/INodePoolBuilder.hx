package pw.tales.cofdsystem.parser.nodes;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

interface INodePoolBuilder extends INode {
    function build(gameObject:GameObject):IMathOperation<Int>;
}
