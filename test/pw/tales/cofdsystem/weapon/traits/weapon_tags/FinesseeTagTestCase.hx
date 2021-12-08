package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class FinesseeTagTestCase extends WeaponTagTestCase
{
    private override function getTagType():TraitType<Dynamic>
    {
        return FinesseTag.TYPE;
    }

    private function testApplyBonusToAttacker():Void
    {
        var action = new AttackBuilder(c1, c2).build();
        action.execute();

        this.assertTraits(action, c1, [Attributes.DEXTERITY, Skills.WEAPONRY]);
        this.assertTraits(action, c2, [DefenceAdvantage.TYPE]);
    }

    private function testDontApplyBonusToDefence():Void
    {
        var action = new AttackBuilder(c2, c1).build();
        action.execute();

        this.assertTraits(action, c1, [DefenceAdvantage.TYPE]);
        this.assertTraits(action, c2, [Attributes.STRENGTH, Skills.WEAPONRY]);
    }
}
