package pw.tales.cofdsystem.dices;

import haxe.unit.TestCase;

class EnumExplodeTestCase extends TestCase
{
    public function testNext()
    {
        var explode = EnumExplode.DEFAULT.next();
        assertEquals(explode, EnumExplode.NINE_AGAIN);

        explode = explode.next();
        assertEquals(explode, EnumExplode.EIGHT_AGAIN);

        explode = explode.next();
        assertEquals(explode, EnumExplode.ROTE_ACTION);

        explode = explode.next();
        assertEquals(explode, EnumExplode.NONE);

        explode = explode.next();
        assertEquals(explode, EnumExplode.DEFAULT);
    }
}
