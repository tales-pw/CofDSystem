package pw.tales.cofdsystem.synchronization.serialization;

class Serialization<TYPE, DATA>
{
    public function createNewObj(data:DATA):TYPE
        throw "Not Implemented";

    public function updateWithData(obj:TYPE, data:DATA):TYPE
        throw "Not Implemented";

    public function fromData(data:DATA):TYPE
    {
        var obj = this.createNewObj(data);
        return this.updateWithData(obj, data);
    }

    public function toData(obj:TYPE):DATA
        throw "Not Implemented";

    public function update(obj:TYPE, serializedData:String):TYPE
    {
        var data:DATA = haxe.Json.parse(serializedData);
        return this.updateWithData(obj, data);
    }

    public function deserialize(serializedData:String):TYPE
    {
        var data:DATA = haxe.Json.parse(serializedData);
        return this.fromData(data);
    }

    public function serialize(obj:TYPE):String
    {
        var data:DATA = toData(obj);
        return haxe.Json.stringify(data);
    }
}
