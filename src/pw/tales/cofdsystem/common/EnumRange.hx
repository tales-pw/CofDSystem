package pw.tales.cofdsystem.common;

@SuppressWarnings("checkstyle:Type")
class EnumRange
{
    private static var VALUES:Array<EnumRange> = [];

    // Order matters, it should go in order of ascending distance
    public static final CLOSE = new EnumRange("close", 5.0);
    public static final SHORT = new EnumRange("short", 30.0);
    public static final MEDIUM = new EnumRange("medium", 100.0);
    public static final LONG = new EnumRange("long", 300.0);
    public static final EXTREME = new EnumRange("extreme", Math.POSITIVE_INFINITY);

    private var name:String;
    private var distance:Float;

    private function new(name:String, distance:Float)
    {
        this.name = name;
        this.distance = distance;

        VALUES.push(this);
    }

    public function getDistance():Float
    {
        return this.distance;
    }

    public static function measure(value:Int):EnumRange
    {
        for (range in VALUES)
        {
            if (value < range.getDistance())
                return range;
        }
        return EnumRange.EXTREME;
    }

    public static function findByName(name:String):Null<EnumRange>
    {
        for (range in VALUES)
            if (range.name == name)
                return range;
        return null;
    }
}
