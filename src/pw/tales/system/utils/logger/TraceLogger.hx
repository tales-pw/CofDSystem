package pw.tales.system.utils.logger;

@SuppressWarnings("checkstyle:Trace")
class TraceLogger implements ILogger {
    public function new() {
    }

    public function info(text:String) {
        trace(text);
    }

    public function warning(text:String) {
        trace(text);
    }

    public function error(text:String) {
        trace(text);
    }
}
