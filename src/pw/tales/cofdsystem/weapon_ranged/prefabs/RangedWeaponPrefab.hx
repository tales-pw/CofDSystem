package pw.tales.cofdsystem.weapon_ranged.prefabs;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.weapon_ranged.traits.RangedWeapon;

@:structInit class RangedWeaponPrefab extends WeaponPrefab
{
    private override function setUpGameObject(weaponGameObject:GameObject):Void
    {
        super.setUpGameObject(weaponGameObject);

        final manager = weaponGameObject.getTraitManager();
        manager.addTrait(RangedWeapon.TYPE);
    }
}
