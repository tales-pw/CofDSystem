package pw.tales.cofdsystem.dices.pool.builder;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

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
