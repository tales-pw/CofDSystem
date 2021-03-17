package pw.tales.system.action;

import pw.tales.system.action.opposition.base.Opposition;
import pw.tales.system.scene.Scene;

interface IAction {
    function getOpposition():Opposition;

    function getActionTime():EnumTime;

    function addModification(modification:IModification):Void;

    function getModifications():Array<IModification>;

    function execute(system:CofDSystem, scene:Null<Scene> = null):Void;
}