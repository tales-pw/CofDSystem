package pw.tales.cofdsystem.weapon_melee.prefabs;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.weapon_melee.traits.MeleeWeapon;

class MeleeWeaponPrefab extends WeaponPrefab
{
    private override function setUpGameObject(weaponGameObject:GameObject)
    {
        super.setUpGameObject(weaponGameObject);

        final manager = weaponGameObject.getTraitManager();
        manager.addTrait(MeleeWeapon.TYPE);
    }
}
