package pw.tales.system.utils.logger;

import thx.error.NotImplemented;

class ABCLogger implements ILogger {
    public function new() {}

    public function info(text:String) throw new NotImplemented();

    public function warning(text:String) throw new NotImplemented();

    public function error(text:String) throw new NotImplemented();
}
