package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.equipment.traits.StrengthReq;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class TwoHandedTagTestCase extends WeaponTagTestCase
{
    private override function getTagType():TraitType<Dynamic>
    {
        return TwoHandedTag.TYPE;
    }

    public function test()
    {
        this.weapon.getGameObject().getTrait(StrengthReq.TYPE).setValue(4);
        this.c1.getTrait(Attributes.STRENGTH).setValue(3);

        this.c1.getTrait(HeldWeapon.TYPE).setOffHand(this.createNoTagWeapon());

        var action = new AttackBuilder(c2, c1).build();
        action.execute();

        this.assertBonusNamed(action, c1, StrengthReq.DN, -6);
        this.assertBonusNamed(action, c2, StrengthReq.DN, null);
    }
}
