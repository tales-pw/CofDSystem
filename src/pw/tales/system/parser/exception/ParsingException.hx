package pw.tales.system.parser.exception;

class ParsingException {
    private var error:String;

    public function new(error:String) {
        this.error = error;
    }

    public function getError():String {
        return error;
    }
}
