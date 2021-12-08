package pw.tales.cofdsystem.utils.logger;

@:expose("LoggerManager")
class LoggerManager
{
    private static var LOGGER:ILogger = new TraceLogger();

    public static function getLogger():ILogger
    {
        return LoggerManager.LOGGER;
    }

    public static function setLogger(logger:ILogger):Void
    {
        LoggerManager.LOGGER = logger;
    }
}
