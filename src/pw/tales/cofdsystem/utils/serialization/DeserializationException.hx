package pw.tales.cofdsystem.utils.serialization;

import pw.tales.cofdsystem.exceptions.CofDSystemException;

class DeserializationException extends CofDSystemException
{
    private final data:Dynamic;
    private final field:String;

    public function new(data:Dynamic, field:String)
    {
        super('Field "${field}" not found in ${data}.');
        this.data = data;
        this.field = field;
    }

    public function getData():Dynamic
    {
        return this.data;
    }

    public function getField():String
    {
        return this.field;
    }
}
