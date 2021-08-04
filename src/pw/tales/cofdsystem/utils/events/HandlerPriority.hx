package pw.tales.cofdsystem.utils.events;

class HandlerPriority
{
    public static final LOWEST:Int = 0;
    public static final LOW:Int = 25;
    public static final NORMAL:Int = 50;
    public static final HIGH:Int = 75;
    public static final HIGHEST:Int = 100;

    private static function sortedCopy(prorities:Array<Int>):Array<Int>
    {
        var copy = prorities.copy();
        copy.sort(HandlerPriority.comparator);
        return copy;
    }

    public static function before(prorities:Array<Int>):Int
    {
        if (prorities.length == 0)
            return NORMAL;
        return sortedCopy(prorities)[prorities.length] + 1;
    }

    public static function after(prorities:Array<Int>):Int
    {
        if (prorities.length == 0)
            return NORMAL;
        return sortedCopy(prorities)[0] - 1;
    }

    public static function comparator(priority1:Int, priority2:Int):Int
    {
        return priority1 - priority2;
    }
}
