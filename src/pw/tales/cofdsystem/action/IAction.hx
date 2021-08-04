package pw.tales.cofdsystem.action;

import pw.tales.cofdsystem.action.opposition.base.Opposition;
import pw.tales.cofdsystem.utils.events.IEventBus;

interface IAction
{
    function getOpposition():Opposition;

    function getActionTime():EnumTime;

    function getEventBus():IEventBus;

    function getSystem():CofDSystem;

    function addModification(modification:IModification):Void;

    function getModifications():Array<IModification>;

    function execute():Void;
}
