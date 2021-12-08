package pw.tales.cofdsystem.character.advantages;

import pw.tales.cofdsystem.character.traits.advantages.willpower.WillpowerAdvantage;

class WillpowerAdvantageTestCase extends CofDSystemTestCase
{
    public function testNoWillpower():Void
    {
        var willpower = c2.getTrait(WillpowerAdvantage.TYPE);

        var exceptionHappened = false;
        try
        {
            for (_ in 0...willpower.getPoints() + 1)
            {
                willpower.burnWillpower();
            }
        } catch (NoWillpowerException)
        {
            exceptionHappened = true;
        }

        assertTrue(exceptionHappened);
    }
}
