package pw.tales.cofdsystem.dices;

import pw.tales.cofdsystem.utils.math.MathValue;
import haxe.unit.TestCase;

class DiceTestCase extends TestCase
{
    public function testDiceRolls():Void
    {
        var roller = new DiceRoller();
        var request = new RollRequest(new MathValue<Int>(10));
        var result = roller.roll(request);
        assertTrue(result.getResults().length >= 10);
    }
}
