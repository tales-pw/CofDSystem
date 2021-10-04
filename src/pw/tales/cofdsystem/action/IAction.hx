package pw.tales.cofdsystem.action;

import pw.tales.cofdsystem.utils.events.IEventBus;

interface IAction
{
    function getActionTime():EnumTime;

    function getEventBus():IEventBus;

    function getSystem():CofDSystem;

    function addModification(modification:IModification):Void;

    function getModifications():Array<IModification>;

    function execute():Void;
}
