package pw.tales.system.common;

import haxe.ds.StringMap;
import pw.tales.system.utils.EnumNamed;

class EnumHand extends EnumNamed {
    public static var VALUES = new StringMap<EnumHand>();

    public static final HAND = new EnumHand("hand");
    public static final OFFHAND = new EnumHand("offhand");

    private function new(name:String) {
        super(name);
        VALUES.set(name, this);
    }

    public static function byName(name:String):EnumHand {
        var value = VALUES.get(name);
        if (value == null) throw "Wrong name";
        return value;
    }
}
