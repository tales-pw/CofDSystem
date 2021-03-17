package pw.tales.system.weapon_ranged.prefabs;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.weapon.prefabs.WeaponPrefab;
import pw.tales.system.weapon_ranged.traits.RangedWeapon;

class RangedWeaponPrefab extends WeaponPrefab {
    private override function setUpGameObject(weaponGameObject:GameObject) {
        super.setUpGameObject(weaponGameObject);

        final manager = weaponGameObject.getTraitManager();
        manager.addTrait(RangedWeapon.TYPE);
    }
}
