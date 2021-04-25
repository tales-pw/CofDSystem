package pw.tales.cofdsystem.parser.exception;

import pw.tales.cofdsystem.exceptions.CofDSystemException;

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
