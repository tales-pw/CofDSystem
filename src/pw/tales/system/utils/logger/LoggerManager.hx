package pw.tales.system.utils.logger;

class LoggerManager {
    private static var LOGGER:ILogger = new TraceLogger();

    public function new() {}

    public static function getLogger():ILogger {
        return LoggerManager.LOGGER;
    }

    public static function setLogger(logger:ILogger) {
        LoggerManager.LOGGER = logger;
    }
}
