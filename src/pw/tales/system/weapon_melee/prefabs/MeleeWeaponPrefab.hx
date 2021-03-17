package pw.tales.system.weapon_melee.prefabs;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.weapon.prefabs.WeaponPrefab;
import pw.tales.system.weapon_melee.traits.MeleeWeapon;

class MeleeWeaponPrefab extends WeaponPrefab {
    private override function setUpGameObject(weaponGameObject:GameObject) {
        super.setUpGameObject(weaponGameObject);

        final manager = weaponGameObject.getTraitManager();
        manager.addTrait(MeleeWeapon.TYPE);
    }
}
