package pw.tales.system.parser.exception;

import pw.tales.system.exceptions.CofDSystemException;

class ParsingException extends CofDSystemException {
    private var error:String;

    public function new(error:String) {
        super(error);
        this.error = error;
    }

    public function getError():String {
        return error;
    }
}
