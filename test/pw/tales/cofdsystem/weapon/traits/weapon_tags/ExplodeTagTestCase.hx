package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.action_attack.builder.EnumResistType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import thx.error.NotImplemented;
import pw.tales.cofdsystem.dices.EnumExplode;
import haxe.unit.TestCase;

class ExplodeTagTestCase extends WeaponTagTestCase
{
    private function getGOExplode(action:AttackAction, gameObject:GameObject):EnumExplode
    {
        var pool = action.getCompetition().getPool(gameObject);
        var request = pool.getRequest();
        return request.getExplode();
    }

    public function testApplyExplodeForAttacker()
    {
        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        assertEquals(this.getExpectedExplode(), this.getGOExplode(action, c1));
        assertEquals(EnumExplode.DEFAULT, this.getGOExplode(action, c2));
    }

    public function testDontApplyExplodeForTarget()
    {
        var action = new AttackBuilder(c2, c1).setResistType(EnumResistType.DODGE).build();
        system.act(action);

        assertEquals(EnumExplode.DEFAULT, this.getGOExplode(action, c1));
        assertEquals(EnumExplode.DEFAULT, this.getGOExplode(action, c2));
    }

    public override function getBaseTest():Class<TestCase>
    {
        return ExplodeTagTestCase;
    }

    public function getExpectedExplode():EnumExplode
    {
        throw new NotImplemented();
    }
}
