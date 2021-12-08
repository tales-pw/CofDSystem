package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.common.EnumSide;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class MercyTagTestCase extends WeaponTagTestCase
{
    private override function getTagType():TraitType<Dynamic>
    {
        return MercyTag.TYPE;
    }

    private function testApplyAttacker():Void
    {
        var action = new AttackBuilder(c1, c2).setModifier(EnumSide.ACTOR, 1).build();
        action.execute();

        this.assertArrayEquals(action.getDamage().getTuple(), [1, 0, 0]);
    }

    private function testDontApplyDefence():Void
    {
        var action = new AttackBuilder(c2, c1).setModifier(EnumSide.ACTOR, 1).build();
        action.execute();

        this.assertArrayEquals(action.getDamage().getTuple(), [0, 1, 0]);
    }
}
