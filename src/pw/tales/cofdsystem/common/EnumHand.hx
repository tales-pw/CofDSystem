package pw.tales.cofdsystem.common;

import haxe.ds.StringMap;
import pw.tales.cofdsystem.utils.EnumNamed;

@:expose("EnumHand")
class EnumHand extends EnumNamed
{
    public static final VALUES = new StringMap<EnumHand>();

    public static final HAND = new EnumHand("hand");
    public static final OFFHAND = new EnumHand("offhand");

    private function new(name:String)
    {
        super(name);
        VALUES.set(name, this);
    }

    public static function byName(name:String):EnumHand
    {
        var value = VALUES.get(name);
        if (value == null)
            throw "Wrong name";
        return value;
    }
}
