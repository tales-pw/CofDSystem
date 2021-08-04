package pw.tales.cofdsystem.dices;

import haxe.ds.StringMap;

class EnumExplode
{
    private static final MAP = new StringMap();

    public static final NONE:EnumExplode = new EnumExplode("none");
    public static final DEFAULT:EnumExplode = new EnumExplode("default", 10);
    public static final NINE_AGAIN:EnumExplode = new EnumExplode("nine_again", 9);
    public static final EIGHT_AGAIN:EnumExplode = new EnumExplode("eight_again", 8);
    public static final ROTE_ACTION:EnumExplode = new EnumExplode("rote_action");

    private var name:String;
    private var explode:Int;

    private function new(name:String, explode:Int = -1)
    {
        this.name = name;
        this.explode = explode;

        MAP.set(this.name, this);
    }

    public static function findByName(name:String)
    {
        return MAP.get(name);
    }

    public function getName():String
    {
        return this.name;
    }

    public function getExplode():Int
    {
        return this.explode;
    }
}
