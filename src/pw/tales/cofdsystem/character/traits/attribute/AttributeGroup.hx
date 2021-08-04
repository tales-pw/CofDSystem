package pw.tales.cofdsystem.character.traits.attribute;

import pw.tales.cofdsystem.utils.EnumNamed;

class AttributeGroup extends EnumNamed
{
    public static var VALUES = new Map<String, AttributeGroup>();

    public static final MENTAL = new AttributeGroup("mental");
    public static final PHYSICAL = new AttributeGroup("physical");
    public static final SOCIAL = new AttributeGroup("social");

    private function new(name:String)
    {
        super(name);
        VALUES.set(name, this);
    }

    public static function byName(name:String):AttributeGroup
    {
        var value = VALUES.get(name);
        if (value == null)
            throw "Wrong name";
        return value;
    }
}
