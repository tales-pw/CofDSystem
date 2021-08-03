package pw.tales.cofdsystem.serialization.system.serializers;

import thx.error.AbstractMethod;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.registry.Registry;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.serialization.system.SystemData;

class WeaponSerializer extends Serializer<WeaponData, WeaponPrefab> {
    private final registry: Registry<WeaponPrefab>;
    private final traitRegistry:TraitTypeRegistry;

    public function new(weaponRegistry: Registry<WeaponPrefab>, traitRegistry:TraitTypeRegistry) {
        this.registry = weaponRegistry;
        this.traitRegistry = traitRegistry;
    }

    public override function updateWithData(result:WeaponPrefab, data:WeaponData):Void {
        throw "create only";
    }

    public override function toData(result:WeaponPrefab):WeaponData {
        return {
            dn: result.getDN(),
            name: result.getName(),
            damage: result.getDamageMod(),
            initiative: result.getInitiativeMod(),
            strength: result.getStrengthReq(),
            size: result.getSize(),
            tags: [for (tag in result.getWeaponTags()) tag.getDN()]
        }
    }

    public override function fromData(data:WeaponData):WeaponPrefab {
        var weapon = this.registry.getRecord(data.dn);
        if (weapon == null) {
            weapon = this.create(data);
            this.registry.register(weapon);
        }
        return weapon;
    }

    private function create(data: WeaponData): WeaponPrefab {
        throw new AbstractMethod();
    }

    private function getTags(tagsDns: Array<String>): Array<TraitType<Dynamic>> {
        var tags:Array<TraitType<Dynamic>> = [];
        for (dn in tagsDns) {
            var record: Null<TraitType<Dynamic>> = cast this.traitRegistry.getRecord(dn);
            if (record == null) throw 'Tag not found ${dn}';
            tags.push(record);
        }
        return tags;
    }
}
