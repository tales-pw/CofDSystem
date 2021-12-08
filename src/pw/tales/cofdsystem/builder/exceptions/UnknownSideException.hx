package pw.tales.cofdsystem.builder.exceptions;

import haxe.Exception;

@:expose("UnknownSideException")
class UnknownSideException extends Exception
{
    public function new()
    {
        super("Unknown side.");
    }
}
