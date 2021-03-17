package pw.tales.system.synchronization.minecraft.serialization;

import pw.tales.system.weapon.prefabs.WeaponPrefab;
import pw.tales.system.weapon_melee.prefabs.MeleeWeaponPrefab;
import pw.tales.system.weapon_ranged.prefabs.RangedWeaponPrefab;

class WeaponSerialization {
    public static function serialize(weapon:Dynamic):Dynamic {
        var meleeWeapon = Std.downcast(weapon, MeleeWeaponPrefab);
        if (meleeWeapon != null) return MeleeWeaponSerialization.serialize(meleeWeapon);

        var rangedWeapon = Std.downcast(weapon, RangedWeaponPrefab);
        if (rangedWeapon != null) return RangedWeaponSerialization.serialize(rangedWeapon);

        throw "Unknown weapon type.";
    }

    public static function deserialize(tagRegistry:TraitTypeRegistry, data:Dynamic):WeaponPrefab {
        if (data.type == MeleeWeaponSerialization.TYPE) return MeleeWeaponSerialization.deserialize(tagRegistry, data);
        if (data.type == RangedWeaponSerialization.TYPE) return RangedWeaponSerialization.deserialize(tagRegistry, data);

        throw "Unknown weapon type.";
    }
}
