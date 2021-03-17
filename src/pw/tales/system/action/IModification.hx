package pw.tales.system.action;

interface IModification {
    function before(action:IAction):Void;

    function after(action:IAction):Void;
}
