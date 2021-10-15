package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class AccurateTagTestCase extends WeaponTagTestCase
{
    private override function getTagType():TraitType<Dynamic>
    {
        return AccurateTag.TYPE;
    }

    private function testApplyBonusToAttacker()
    {
        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        this.assertBonus(action, c1, 1);
        this.assertBonus(action, c2, null);
    }

    private function testDontApplyBonusToDefence()
    {
        var action = new AttackBuilder(c2, c1).build();
        system.act(action);

        this.assertBonus(action, c1, null);
        this.assertBonus(action, c2, null);
    }
}