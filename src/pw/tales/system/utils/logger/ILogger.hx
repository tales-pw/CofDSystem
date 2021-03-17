package pw.tales.system.utils.logger;

interface ILogger {
    function info(text:String):Void;

    function warning(text:String):Void;

    function error(text:String):Void;
}
