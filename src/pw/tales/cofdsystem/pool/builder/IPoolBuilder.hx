package pw.tales.cofdsystem.pool.builder;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

/**
    Classes implementing this interface are used to describe expression
    without specific GameObject.
**/
interface IPoolBuilder
{
    function getHumanReadable():String;

    function build(gameObject:GameObject):IMathOperation<Int>;
}
