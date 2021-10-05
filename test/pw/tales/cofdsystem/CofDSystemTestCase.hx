package pw.tales.cofdsystem;

import pw.tales.cofdsystem.character.prefabs.HumanPrefab;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.mocks.DiceRollerMock;
import haxe.unit.TestCase;

@:nullSafety(Off)
class CofDSystemTestCase extends TestCase implements WithBaseTest
{
    private var system:CofDSystem;
    private var c1:GameObject;
    private var c2:GameObject;
    private var c3:GameObject;

    override public function setup()
    {
        this.system = new CofDSystem();
        system.dices = cast new DiceRollerMock([], 8);

        this.c1 = HumanPrefab.INSTANCE.createGameObject(system);
        this.c2 = HumanPrefab.INSTANCE.createGameObject(system);
        this.c3 = HumanPrefab.INSTANCE.createGameObject(system);
    }

    public function getBaseTest():Class<TestCase>
    {
        return CofDSystemTestCase;
    }
}
