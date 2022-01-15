package pw.tales.cofdsystem.utils.time;

import thx.Int64s;
import haxe.Int64;
import thx.Time;

class TimeUtils
{
    public static function multiply(time:Time, number:Int):Time
    {
        return new Time(time.ticks * number);
    }

    public static function div(time1:Time, time2:Time):Int
    {
        return Int64.toInt(Int64.div(time1.ticks, time2.ticks));
    }
}
