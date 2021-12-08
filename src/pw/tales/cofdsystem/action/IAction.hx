package pw.tales.cofdsystem.action;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.events.IEventBus;

interface IAction
{
    function getActionTime():EnumTime;

    function getActor():GameObject;

    function getEventBus():IEventBus;

    function getSystem():CofDSystem;

    function addModification(modification:IModification):Void;

    function getModifications():Array<IModification>;

    function isRelated(gameObject:GameObject):Bool;

    function execute():Void;
}
