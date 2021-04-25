package pw.tales.cofdsystem.synchronization.minecraft;

import pw.tales.cofdsystem.synchronization.minecraft.serialization.ExternalArmorSerialization.ExternalArmorData;
import pw.tales.cofdsystem.synchronization.minecraft.serialization.ExternalArmorSerialization;
import pw.tales.cofdsystem.synchronization.minecraft.serialization.MeleeWeaponSerialization.MeleeWeaponData;
import pw.tales.cofdsystem.synchronization.minecraft.serialization.TraitTypeSerialization;
import pw.tales.cofdsystem.synchronization.minecraft.serialization.WeaponSerialization;

typedef SystemData = {
    traitTypes:Array<TraitTypeData>,
    weapons:Array<MeleeWeaponData>,
    armors:Array<ExternalArmorData>
}

@:nullSafety(Off)

@:expose("SystemSynchronization")
class SystemSynchronization {
    // Things serializer needs to know
    public var system:CofDSystem = null;

    private function new(system:CofDSystem) {
        this.system = system;
    }

    public static function create(s:CofDSystem):SystemSynchronization {
        return new SystemSynchronization(s);
    }

    public function deserialize(data:String):SystemSynchronization {
        var deserialized:SystemData = haxe.Json.parse(data);

        for (serializedWeapon in deserialized.weapons) {
            this.system.weapons.register(WeaponSerialization.deserialize(system.traits, serializedWeapon));
        }

        for (serializedArmor in deserialized.armors) {
            this.system.armors.register(ExternalArmorSerialization.deserialize(serializedArmor));
        }

        for (a in deserialized.traitTypes) {
            var serializedTraitType:TraitTypeData = a;
            var record = this.system.traits.getRecord(serializedTraitType.dn);
            if (record != null) record.setName(serializedTraitType.name);
        }

        return this;
    }

    public function serialize():String {
        var serializedWeapons:Array<MeleeWeaponData> = [];
        for (weapon in this.system.weapons.items()) {
            serializedWeapons.push(WeaponSerialization.serialize(weapon));
        }

        var serializedArmor:Array<ExternalArmorData> = [];
        for (armor in this.system.armors.items()) {
            serializedArmor.push(ExternalArmorSerialization.serialize(armor));
        }

        var serializedTraiTypes:Array<TraitTypeData> = [];
        for (traitType in this.system.traits.items()) {
            serializedTraiTypes.push(TraitTypeSerialization.serialize(traitType));
        }

        return haxe.Json.stringify({
            traitTypes: serializedTraiTypes,
            weapons: serializedWeapons,
            armors: serializedArmor
        });
    }
}