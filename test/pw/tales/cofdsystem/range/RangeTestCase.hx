package pw.tales.cofdsystem.range;

import pw.tales.cofdsystem.common.EnumRange;
import haxe.unit.TestCase;

class RangeTestCase extends TestCase
{
    public function assertRangeEquals(range:EnumRange, meters:Int):Void
    {
        assertEquals(range, EnumRange.measure(meters));
    }

    public function testActions():Void
    {
        assertRangeEquals(EnumRange.CLOSE, 1);
        assertRangeEquals(EnumRange.SHORT, 25);
        assertRangeEquals(EnumRange.MEDIUM, 95);
        assertRangeEquals(EnumRange.LONG, 295);
        assertRangeEquals(EnumRange.EXTREME, 301);
        assertRangeEquals(EnumRange.EXTREME, 1000);
    }
}
