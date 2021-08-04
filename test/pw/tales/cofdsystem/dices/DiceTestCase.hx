package pw.tales.cofdsystem.dices;

import pw.tales.cofdsystem.dices.DiceRoller;
import pw.tales.cofdsystem.utils.math.MathValue;

class DiceTestCase extends haxe.unit.TestCase
{
    public function testDiceRolls()
    {
        var roller = new DiceRoller();
        var request = new RollRequest(new MathValue<Int>(10));
        var result = roller.roll(request);
        assertTrue(result.getResults().length >= 10);
    }
}
