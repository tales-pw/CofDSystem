package pw.tales.cofdsystem.synchronization.serialization.system.exceptions;

import pw.tales.cofdsystem.exceptions.CofDSystemException;

@:expose("ParsingError")
class ParsingError extends CofDSystemException
{
    public function new(data:Dynamic)
    {
        super('Error while parsing ${data}');
    }
}
