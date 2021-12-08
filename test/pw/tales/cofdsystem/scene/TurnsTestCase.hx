package pw.tales.cofdsystem.scene;

import pw.tales.cofdsystem.mocks.CharacterMock;
import pw.tales.cofdsystem.mocks.DiceRollerMock;
import haxe.unit.TestCase;

class TurnsTestCase extends TestCase
{
    public function testInitiative():Void
    {
        var system = new CofDSystem();
        system.dices = new DiceRollerMock([4, 8, 6]);

        var c1 = new CharacterMock(system);
        var c2 = new CharacterMock(system);
        var c3 = new CharacterMock(system);

        var scene = Scene.create(system);
        var turns = scene.getTurns();
        var initiative = scene.getInitiative();
        initiative.add(c1);
        initiative.add(c2);
        initiative.add(c3);
        turns.start();

        assertEquals(Std.string(c2), Std.string(turns.getTurn()));
        turns.nextTurn();
        assertEquals(Std.string(c3), Std.string(turns.getTurn()));
        turns.nextTurn();
        assertEquals(Std.string(c1), Std.string(turns.getTurn()));
        turns.nextTurn();
        assertEquals(Std.string(c2), Std.string(turns.getTurn()));
    }
}
