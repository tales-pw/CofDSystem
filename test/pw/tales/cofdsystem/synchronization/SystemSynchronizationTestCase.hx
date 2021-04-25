package pw.tales.cofdsystem.synchronization;

import pw.tales.cofdsystem.armor.prefabs.ArmorPrefab;
import pw.tales.cofdsystem.synchronization.minecraft.SystemSynchronization;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.AccurateTag;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.BrawlTag;
import pw.tales.cofdsystem.weapon_melee.prefabs.MeleeWeaponPrefab;
import pw.tales.cofdsystem.weapon_ranged.prefabs.RangedWeaponPrefab;

class SystemSynchronizationTestCase extends haxe.unit.TestCase {
    public function testFullSync() {
        var system1 = new CofDSystem();
        system1.weapons.register(new MeleeWeaponPrefab("weapon1", "", 1, 2, [AccurateTag.TYPE]));
        system1.weapons.register(new MeleeWeaponPrefab("weapon2", "", 3, 4, [BrawlTag.TYPE]));
        system1.weapons.register(new MeleeWeaponPrefab("weapon3", "", 5, 6, [AccurateTag.TYPE]));

        system1.weapons.register(new RangedWeaponPrefab("weapon4", "", 1, 2, [AccurateTag.TYPE]));
        system1.weapons.register(new RangedWeaponPrefab("weapon5", "", 3, 4, [BrawlTag.TYPE]));
        system1.weapons.register(new RangedWeaponPrefab("weapon6", "", 5, 6, [AccurateTag.TYPE]));

        system1.armors.register(new ArmorPrefab("armor1", "", 1, 2, 3, 4, 5));
        system1.armors.register(new ArmorPrefab("armor2", "", 6, 7, 8, 9, 10));
        system1.armors.register(new ArmorPrefab("armor3", "", 11, 12, 13, 14, 15));
        var data = SystemSynchronization.create(system1).serialize();

        var system2 = new CofDSystem();
        SystemSynchronization.create(system2).deserialize(data);

        for (weapon in system1.weapons.items()) {
            assertEquals(Std.string(weapon), Std.string(system2.weapons.getRecord(weapon.getDN())));
        }

        for (armor in system1.armors.items()) {
            assertEquals(Std.string(armor), Std.string(system2.armors.getRecord(armor.getDN())));
        }
    }
}