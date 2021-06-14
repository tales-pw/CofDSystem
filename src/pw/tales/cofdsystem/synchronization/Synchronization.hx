package pw.tales.cofdsystem.synchronization;

class Synchronization<DATA, RESULT> {
    public function updateWithData(result:RESULT, data:DATA):Void;

    public function fromData(data:DATA):RESULT;

    public function toData(result: RESULT):DATA;

    public function deserialize(serializedData:String):RESULT {
        var data:DATA = haxe.Json.parse(serializedData);
        return this.fromData(data);
    }

    public function serialize(result: RESULT):String {
        return haxe.Json.stringify(toData(result));
    }
}