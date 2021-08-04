package pw.tales.cofdsystem.serialization.system.serializers;

import pw.tales.cofdsystem.serialization.system.SystemData;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.weapon_melee.prefabs.MeleeWeaponPrefab;

class ArmorSerializer extends SystemSubSerializer<ArmorData, WeaponPrefab>  {
    public function new(system: CofDSystem) {
        super(system);
    }
}
