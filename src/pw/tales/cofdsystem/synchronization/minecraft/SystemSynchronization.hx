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
    
    public function fromData(deserialized:SystemData):SystemSynchronization {
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
    
    public function toData():SystemData {
        var serializedWeapons:Array<MeleeWeaponData> = [];
        for (weapon in this.system.weapons.items()) {
            serializedWeapons.push(WeaponSerialization.serialize(weapon));
        }

        var serializedArmor:Array<ExternalArmorData> = [];
        for (armor in this.system.armors.items()) {
            serializedArmor.push(ExternalArmorSerialization.serialize(armor));
        }

        var serializedTraitTypes:Array<TraitTypeData> = [];
        for (traitType in this.system.traits.items()) {
            serializedTraitTypes.push(TraitTypeSerialization.serialize(traitType));
        }

        return {
            traitTypes: serializedTraitTypes,
            weapons: serializedWeapons,
            armors: serializedArmor
        };
    }
    
    public function deserialize(serializedData:String):SystemSynchronization {
        var data:SystemData = haxe.Json.parse(serializedData);
        return this.fromData(data);
    }

    public function serialize():String {
        var data:SystemData = this.toData();
        return haxe.Json.stringify(data);
    }

}