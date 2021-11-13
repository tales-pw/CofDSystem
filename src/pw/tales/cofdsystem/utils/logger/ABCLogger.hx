package pw.tales.cofdsystem.utils.logger;

import thx.error.NotImplemented;

@:expose("ABCLogger")
class ABCLogger implements ILogger
{
    public function new() {}

    public function info(text:String)
        throw new NotImplemented();

    public function warning(text:String)
        throw new NotImplemented();

    public function error(text:String)
        throw new NotImplemented();
}
