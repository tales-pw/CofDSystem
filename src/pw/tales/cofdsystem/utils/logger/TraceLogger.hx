package pw.tales.cofdsystem.utils.logger;

@SuppressWarnings("checkstyle:Trace")
@:expose("TraceLogger")
class TraceLogger implements ILogger
{
    public function new() {}

    public function info(text:String)
    {
        trace(text);
    }

    public function warning(text:String)
    {
        trace(text);
    }

    public function error(text:String)
    {
        trace(text);
    }
}
