package pw.tales.system.dices.pool.builder;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;

/*

 */
class PoolBuilder implements IPoolBuilder {
    public function new() {}

    public function getHumanReadable():String {
        throw "Unimplemented";
    }

    public function build(gameObject:GameObject):IMathOperation<Int> {
        throw "Unimplemented";
    }

    public function plus(other:IPoolBuilder):IPoolBuilder {
        return new PBSum(this, other);
    }
}
