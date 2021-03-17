package pw.tales.system.dices.pool;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.math.IMathOperation;

/**
    Classes implementing this interface are used to describe expression
    without specific GameObject.
**/
interface IPoolBuilder {
    function plus(other:IPoolBuilder):IPoolBuilder;

    function getHumanReadable():String;

    function build(gameObject:GameObject):IMathOperation<Int>;
}
