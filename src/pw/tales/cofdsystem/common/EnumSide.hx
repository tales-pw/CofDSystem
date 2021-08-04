package pw.tales.cofdsystem.common;

import haxe.ds.StringMap;
import pw.tales.cofdsystem.utils.EnumNamed;

class EnumSide extends EnumNamed
{
    public static var VALUES = new StringMap<EnumSide>();

    public static final ACTOR = new EnumSide("actor");
    public static final TARGET = new EnumSide("target");

    private function new(name:String)
    {
        super(name);
        VALUES.set(name, this);
    }

    public static function byName(name:String):EnumSide
    {
        var value = VALUES.get(name);
        if (value == null)
            throw "Wrong name";
        return value;
    }
}
