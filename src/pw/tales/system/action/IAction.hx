package pw.tales.system.action;

import pw.tales.system.action.opposition.base.Opposition;
import pw.tales.system.utils.events.IEventBus;

interface IAction {
    function getOpposition():Opposition;

    function getActionTime():EnumTime;

    function getEventBus():IEventBus;

    function getSystem():CofDSystem;

    function addModification(modification:IModification):Void;

    function getModifications():Array<IModification>;

    function execute():Void;
}