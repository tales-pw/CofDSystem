package pw.tales.cofdsystem.serialization;

import thx.error.AbstractMethod;

class Serializer<DATA, RESULT>
{
    private function new() {}

    public function updateWithData(result:RESULT, data:DATA):Void
        throw new AbstractMethod();

    public function fromData(data:DATA):RESULT
        throw new AbstractMethod();

    public function toData(result:RESULT):DATA
        throw new AbstractMethod();

    public function deserialize(serializedData:String):RESULT
    {
        var data:DATA = haxe.Json.parse(serializedData);
        return this.fromData(data);
    }

    public function serialize(result:RESULT):String
    {
        return haxe.Json.stringify(toData(result));
    }
}
