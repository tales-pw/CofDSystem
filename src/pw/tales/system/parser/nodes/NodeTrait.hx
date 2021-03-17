package pw.tales.system.parser.nodes;

import pw.tales.system.dices.pool.math.PoolTrait;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;

class NodeTrait implements INode implements INodePoolBuilder {
    private var dn:String;

    public function new(dn:String) {
        this.dn = dn;
    }

    public function getHumanReadable():String {
        return '[[${dn}]]';
    }

    public function getValue():String {
        return dn;
    }

    public function build(gameObject:GameObject):IMathOperation<Int> {
        return new PoolTrait(gameObject, this.dn);
    }

    public function toString():String {
        return 'NodeTrait[${this.dn}]';
    }
}
