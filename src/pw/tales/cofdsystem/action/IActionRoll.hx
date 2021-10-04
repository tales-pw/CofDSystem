package pw.tales.cofdsystem.action;

import pw.tales.cofdsystem.action.pool.ActionPool;
import pw.tales.cofdsystem.game_object.GameObject;

interface IActionRoll
{
    function willRoll(roll:ActionPool):Bool;

    function isRelated(gameObject:GameObject):Bool;

    function roll(action:IAction):Void;
}
