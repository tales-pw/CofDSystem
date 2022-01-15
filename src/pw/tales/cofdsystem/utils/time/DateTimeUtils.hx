package pw.tales.cofdsystem.utils.time;

import thx.Time;
import thx.DateTime;

class DateTimeUtils
{
    public static function fixedSubtractDate(date1:DateTime, date2:DateTime):Time
    {
        return new Time(date1.utc.ticks - date2.utc.ticks);
    }
}
