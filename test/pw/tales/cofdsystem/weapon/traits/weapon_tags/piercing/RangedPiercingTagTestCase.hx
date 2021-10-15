package pw.tales.cofdsystem.weapon.traits.weapon_tags.piercing;

import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.weapon_ranged.prefabs.RangedWeaponPrefab;
import pw.tales.cofdsystem.common.EnumSide;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;

class RangedPiercingTagTestCase extends PiercingTagTestCase
{
    private override function createPrefab():WeaponPrefab
    {
        return new RangedWeaponPrefab("weapon", null, 0, 0, 0, 0, [this.getTagType()]);
    }

    public function testApplyToGeneral()
    {
        this.setupGOArmor(c2, 3, 0);

        var action = new AttackBuilder(c1, c2).setModifier(EnumSide.ACTOR, 4).build();
        system.act(action);

        // Damage is 5L, effective armor is 1/0
        assertArrayEquals([0, 4, 0], action.getDamage().getTuple());
    }

    public function testApplyToBallistic()
    {
        this.setupGOArmor(c2, 0, 3);

        var action = new AttackBuilder(c1, c2).setModifier(EnumSide.ACTOR, 4).build();
        system.act(action);

        // Damage is 5L, effective armor is 0/1
        assertArrayEquals([1, 4, 0], action.getDamage().getTuple());
    }

    public function testApplyToBoth()
    {
        this.setupGOArmor(c2, 2, 2);

        var action = new AttackBuilder(c1, c2).setModifier(EnumSide.ACTOR, 4).build();
        system.act(action);

        // Damage is 5L, effective armor is 2/0
        assertArrayEquals([0, 3, 0], action.getDamage().getTuple());
    }
}
