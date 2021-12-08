package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.weapon_melee.prefabs.MeleeWeaponPrefab;
import pw.tales.cofdsystem.weapon.Weapon;

class StrengthReqTestCase extends CofDSystemTestCase
{
    private final STR_REQ = 4;

    public function createWeapon():Weapon
    {
        var prefab:MeleeWeaponPrefab = {
            dn: "weapon",
            strength: 4
        };
        return prefab.createWeapon(this.system);
    }

    public function testApply():Void
    {
        this.c1.getTrait(HeldWeapon.TYPE).setMainHand(this.createWeapon());
        this.c1.getTrait(Attributes.STRENGTH).setValue(3);

        var action = new AttackBuilder(c2, c1).build();
        action.execute();

        this.assertBonusNamed(action, c1, StrengthReq.DN, -3);
        this.assertBonusNamed(action, c2, StrengthReq.DN, null);
    }
}
