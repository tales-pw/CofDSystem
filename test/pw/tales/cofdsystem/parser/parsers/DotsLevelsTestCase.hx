package pw.tales.cofdsystem.parser.parsers;

import haxe.unit.TestCase;

class DotsLevelsTestCase extends TestCase
{
    public static final parser = new DotsLevelsParser();

    public function assertArrayEquals(a:Array<Int>, b:Array<Int>):Void
    {
        assertEquals(a.toString(), b.toString());
    }

    public function testParser():Void
    {
        var result = parser.parse("3");
        assertEquals("•••", result.getHumanReadable());
        assertArrayEquals([3], result.getLevels());

        var result = parser.parse("от 2 до 5");
        assertEquals("от •• до •••••", result.getHumanReadable());
        assertArrayEquals([2, 3, 4, 5], result.getLevels());

        var result = parser.parse("1 или 2 или 5");
        assertEquals("• или •• или •••••", result.getHumanReadable());
        assertArrayEquals([1, 2, 5], result.getLevels());

        var result = parser.parse("2 или 5");
        assertEquals("•• или •••••", result.getHumanReadable());
        assertArrayEquals([2, 5], result.getLevels());

        var result = parser.parse("1 или 3 или 5");
        assertEquals("• или ••• или •••••", result.getHumanReadable());
        assertArrayEquals([1, 3, 5], result.getLevels());

        var result = parser.parse("1 или 2 или 3 или 5");
        assertEquals("• или •• или ••• или •••••", result.getHumanReadable());
        assertArrayEquals([1, 2, 3, 5], result.getLevels());
    }
}
