package pw.tales.cofdsystem;

import haxe.PosInfos;
import thx.Set;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.action_attack.AttackAction;
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

    override public function setup():Void
    {
        this.system = new CofDSystem();
        system.dices = new DiceRollerMock([], 8);

        this.c1 = HumanPrefab.INSTANCE.createGameObject(system);
        this.c2 = HumanPrefab.INSTANCE.createGameObject(system);
        this.c3 = HumanPrefab.INSTANCE.createGameObject(system);
    }

    private function assertBonusNamed(
        action:AttackAction,
        gameObject:GameObject,
        name:String,
        value:Null<Int>
    ):Void
    {
        var pool = action.getCompetition().getPool(gameObject);
        var request = pool.getRequest();
        var modifiers = request.getAppliedModifiers();
        assertEquals(value, modifiers[name]);
    }

    private function assertTraits(
        action:AttackAction,
        gameObject:GameObject,
        traits:Array<TraitType<Dynamic>>
    ):Void
    {
        var pool = action.getCompetition().getPool(gameObject);
        var request = pool.getRequest();
        this.assertArrayEquals(traits.map(v -> v.getDN()), request.getTraits());
    }

    public function assertObjectEquals(expected:Dynamic, actual:Dynamic):Void
    {
        this.assertEquals(Std.string(expected), Std.string(actual));
    }

    public function assertArrayEquals(expected:Array<Dynamic>, actual:Array<Dynamic>):Void
    {
        this.assertObjectEquals(expected, actual);
    }

    public function assertGOEquals(gameObject1:GameObject, gameObject2:GameObject):Void
    {
        this.assertEquals(gameObject1.getDN(), gameObject2.getDN());
        this.assertEquals(gameObject1.version, gameObject2.version);

        var dns1 = Set.createString([
            for (trait in gameObject1.getTraits()) trait.getDN()
        ]);
        var dns2 = Set.createString([
            for (trait in gameObject2.getTraits()) trait.getDN()
        ]);

        for (dn in dns1.union(dns2))
        {
            var trait1 = gameObject1.getTraitManager().getTraitByDn(dn);
            var trait2 = gameObject2.getTraitManager().getTraitByDn(dn);

            this.assertObjectEquals(trait1.serialize(), trait2.serialize());
        }
    }

    @:nullSafety(Off)
    public function assertNotEquals<T>(
        expected:Null<T>,
        actual:Null<T>,
        c:Null<PosInfos> = null
    ):Void
    {
        currentTest.done = true;
        if (actual == expected)
        {
            currentTest.success = false;
            currentTest.error = "expected '" + expected + "' not to be equal to '" + actual + "'";
            currentTest.posInfos = c;
            throw currentTest;
        }
    }

    public function getBaseTest():Class<TestCase>
    {
        return CofDSystemTestCase;
    }
}
