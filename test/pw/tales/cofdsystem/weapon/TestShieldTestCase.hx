package pw.tales.cofdsystem.weapon;

import pw.tales.cofdsystem.weapon.traits.weapon_tags.ConcealedTag;
import haxe.Exception;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;

class TestShieldTestCase extends CofDSystemTestCase
{
    private function createShieldPrefab(size:Int):WeaponPrefab
    {
        return new WeaponPrefab("shield", "name", 0, 0, size, [
            ConcealedTag.TYPE
        ]);
    }

    private function methodTestShield(size:Int)
    {
        var prefab = this.createShieldPrefab(size);
        var weapon = prefab.createWeapon(this.system);

        var trait = this.c1.getTrait(HeldWeapon.TYPE);
        trait.setHand(EnumHand.HAND, weapon);

        var action = new AttackBuilder(c2, c1).build();
        system.act(action);

        var pool = action.getCompetition().getPool(c1);

        if (pool == null)
        {
            throw new Exception("shouldn't be null");
        }

        var request = pool.getRequest();
        var modifiers = request.getAppliedModifiers();

        assertEquals(modifiers[ConcealedTag.TYPE.getDN()], size);
    }

    public function testShield()
    {
        for (size in 1...5)
        {
            this.methodTestShield(size);
        }
    }
}
