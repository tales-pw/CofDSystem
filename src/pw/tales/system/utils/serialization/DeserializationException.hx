package pw.tales.system.utils.serialization;

class DeserializationException {
    private final data:Dynamic;
    private final field:String;

    public function new(data:Dynamic, field:String) {
        this.data = data;
        this.field = field;
    }

    public function getData():Dynamic {
        return this.data;
    }

    public function getField():String {
        return this.field;
    }
}