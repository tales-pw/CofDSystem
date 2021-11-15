package pw.tales.cofdsystem.action_attack.builder;

import haxe.ds.StringMap;
import pw.tales.cofdsystem.utils.EnumNamed;

@:expose("EnumResistType")
class EnumResistType extends EnumNamed
{
    public static var VALUES = new StringMap<EnumResistType>();

    public static final DEFAULT = new EnumResistType("default");
    public static final DODGE = new EnumResistType("dodge");
    public static final NO_DEFENCE = new EnumResistType("no_defence");

    private function new(name:String)
    {
        super(name);
        VALUES.set(name, this);
    }

    public static function byName(name:String):EnumResistType
    {
        var value = VALUES.get(name);
        if (value == null)
            throw "Wrong name";
        return value;
    }
}
