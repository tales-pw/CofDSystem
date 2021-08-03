package pw.tales.cofdsystem.serialization.system.serializers;

import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.serialization.system.SystemData;

class WeaponSerializer extends Serializer<WeaponData, WeaponPrefab> {
    private final registry:TraitTypeRegistry;

    public function new(registry:TraitTypeRegistry) {
        this.registry = registry;
    }

    public override function updateWithData(result:WeaponPrefab, data:WeaponData):Void {

    }

    public override function toData(result:WeaponPrefab):WeaponData {

    }

    public override function fromData(data:WeaponData):WeaponPrefab {
        record = new WeaponPrefab(data.dn);
        registry.register(record);

        return record;
    }
}
