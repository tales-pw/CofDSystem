package pw.tales.system.character.traits.attribute;

import pw.tales.system.utils.EnumNamed;

class AttributePurpose extends EnumNamed {
    private static var VALUES = new Map<String, AttributePurpose>();

    public static final POWER = new AttributePurpose("power");
    public static final FINESSE = new AttributePurpose("finesse");
    public static final RESISTANCE = new AttributePurpose("resistance");

    private function new(name:String) {
        super(name);
        VALUES.set(name, this);
    }

    public static function byName(name:String):AttributePurpose {
        var value = VALUES.get(name);
        if (value == null) throw "Wrong name";
        return value;
    }
}