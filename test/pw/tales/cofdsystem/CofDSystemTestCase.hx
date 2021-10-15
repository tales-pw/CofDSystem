package pw.tales.cofdsystem;

import pw.tales.cofdsystem.character.prefabs.HumanPrefab;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.mocks.DiceRollerMock;
import haxe.unit.TestCase;

class CofDSystemTestCase extends TestCase implements WithBaseTest
{
    @:nullSafety(Off)
    private var system:CofDSystem;

    @:nullSafety(Off)
    private var c1:GameObject;

    @:nullSafety(Off)
    private var c2:GameObject;

    @:nullSafety(Off)
    private var c3:GameObject;

    override public function setup()
    {
        this.system = new CofDSystem();
        system.dices = new DiceRollerMock([], 8);

        this.c1 = HumanPrefab.INSTANCE.createGameObject(system);
        this.c2 = HumanPrefab.INSTANCE.createGameObject(system);
        this.c3 = HumanPrefab.INSTANCE.createGameObject(system);
    }

    public function getBaseTest():Class<TestCase>
    {
        return CofDSystemTestCase;
    }
}
