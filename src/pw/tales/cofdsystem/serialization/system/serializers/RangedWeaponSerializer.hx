package pw.tales.cofdsystem.serialization.system.serializers;

import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.serialization.system.SystemData;
import pw.tales.cofdsystem.weapon_ranged.prefabs.RangedWeaponPrefab;

class RangedWeaponSerializer extends WeaponSerializer {
    private override function create(data: WeaponData): WeaponPrefab {
        return new RangedWeaponPrefab(
            data.dn,
            data.name,
            data.initiative,
            data.damage,
            data.size,
            data.strength,
            this.getTags(data.tags)
        );
    }
}
