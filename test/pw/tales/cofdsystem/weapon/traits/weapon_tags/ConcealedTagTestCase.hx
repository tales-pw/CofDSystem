package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.ConcealedTag;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;

class ConcealedTagTestCase extends CofDSystemTestCase
{
    private function createShieldPrefab(size:Int):WeaponPrefab
    {
        return new WeaponPrefab("shield", "name", 0, 0, size, [ConcealedTag.TYPE]);
    }

    private function setupGO(gameObject:GameObject, size:Int):Void
    {
        var prefab = this.createShieldPrefab(size);
        var weapon = prefab.createWeapon(this.system);

        var trait = gameObject.getTrait(HeldWeapon.TYPE);
        trait.setHand(EnumHand.HAND, weapon);
    }

    public function testConcealedAppliedWhenTargetWithShield()
    {
        for (size in 1...5)
        {
            this.setupGO(c1, size);

            var action = new AttackBuilder(c2, c1).build();
            system.act(action);

            var pool = action.getCompetition().getPool(c1);
            var request = pool.getRequest();
            var modifiers = request.getAppliedModifiers();

            assertEquals(modifiers[ConcealedTag.TYPE.getDN()], size);
        }
    }

    public function testConcealedNotAppliedWhenActorWithShield()
    {
        this.setupGO(c1, 3);

        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        var pool = action.getCompetition().getPool(c1);
        var request = pool.getRequest();
        var modifiers = request.getAppliedModifiers();

        assertEquals(modifiers[ConcealedTag.TYPE.getDN()], null);
    }
}
