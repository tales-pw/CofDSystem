package pw.tales.cofdsystem.time;

import datetime.DateTime;
import datetime.DateTimeInterval;

class TimeUtils
{
    public static function multiply(interval:DateTimeInterval, number:Int):DateTimeInterval
    {
        var newSeconds = Std.int(interval.getTotalSeconds() * number);
        return toInterval(Second(newSeconds));
    }

    public static function div(interval1:DateTimeInterval, interval2:DateTimeInterval):Int
    {
        var seconds1 = interval1.getTotalSeconds();
        var seconds2 = interval2.getTotalSeconds();
        return Std.int(seconds1 / seconds2);
    }

    public static function toInterval(period:DTPeriod):DateTimeInterval
    {
        var now = DateTime.now();
        return now.add(period) - now;
    }
}
