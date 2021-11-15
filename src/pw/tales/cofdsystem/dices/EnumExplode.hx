package pw.tales.cofdsystem.dices;

import pw.tales.cofdsystem.utils.Utility;
import haxe.ds.StringMap;

@:expose("EnumExplode")
class EnumExplode
{
    private static final KEY_VALUE = new StringMap();
    private static final VALUES = new Array<EnumExplode>();

    public static final NONE:EnumExplode = new EnumExplode("none");
    public static final DEFAULT:EnumExplode = new EnumExplode("default", 10);
    public static final NINE_AGAIN:EnumExplode = new EnumExplode("nine_again", 9);
    public static final EIGHT_AGAIN:EnumExplode = new EnumExplode("eight_again", 8);
    public static final ROTE_ACTION:EnumExplode = new EnumExplode("rote_action");

    private final name:String;
    private final explode:Int;

    private function new(name:String, explode:Int = -1)
    {
        this.name = name;
        this.explode = explode;

        KEY_VALUE.set(this.name, this);
        VALUES.push(this);
    }

    public static function findByName(name:String):Null<EnumExplode>
    {
        return KEY_VALUE.get(name);
    }

    public function next():EnumExplode
    {
        var i = VALUES.indexOf(this) + 1;
        i = i >= VALUES.length ? 0 : i;
        return VALUES[i];
    }

    public function getName():String
    {
        return this.name;
    }

    public function getExplode():Int
    {
        return this.explode;
    }

    public function toString():String
    {
        var className = Utility.getClassName(Type.getClass(this));
        return '${className}[dn=${this.name}]';
    }
}
