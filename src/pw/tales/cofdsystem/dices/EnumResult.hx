package pw.tales.cofdsystem.dices;

class EnumResult {
    public static final FAILURE = new EnumResult("failure");
    public static final DRAMATIC_FAILURE = new EnumResult("dramatic_failure");
    public static final SUCCESS = new EnumResult("success");
    public static final EXCEPTIONAL_SUCCESS = new EnumResult("exceptional_success");

    private var name:String;

    public function new(name:String) {
        this.name = name;
    }

    public function getName():String {
        return this.name;
    }

    public static function isSuccess(result:EnumResult):Bool {
        return result == EnumResult.SUCCESS || result == EnumResult.EXCEPTIONAL_SUCCESS;
    }

    public function toString():String {
        return 'EnumResult[${name}]';
    }
}
