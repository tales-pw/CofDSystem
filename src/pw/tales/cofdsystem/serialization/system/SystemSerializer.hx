package pw.tales.cofdsystem.serialization.system;

import pw.tales.cofdsystem.serialization.system.serializers.RangedWeaponSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.MeleeWeaponSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.AbilitySerializer;
import pw.tales.cofdsystem.serialization.system.serializers.ConditionSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.TiltSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.WeaponTagSerializer;
import pw.tales.cofdsystem.serialization.system.SystemData;

class SystemSerializer extends Serializer<SystemData, CofDSystem> {
    public function new() {}

    public override function updateWithData(result:CofDSystem, data:SystemData):Void {
        var conditionSerializer = new ConditionSerializer(result.traits);
        for (data in data.conditions.iterator()) {
            conditionSerializer.fromData(data);
        }

        var tiltsSerializer = new TiltSerializer(result.traits);
        for (data in data.tilts.iterator()) {
            tiltsSerializer.fromData(data);
        }

        var abilitySerializer = new AbilitySerializer(result.traits);
        for (data in data.abilities.iterator()) {
            abilitySerializer.fromData(data);
        }

        var tagSerializer = new WeaponTagSerializer(result.traits);
        for (data in data.weapon_tags.iterator()) {
            tagSerializer.fromData(data);
        }

        var meleeWeaponSerializer = new MeleeWeaponSerializer(result.weapons, result.traits);
        for (data in data.melee_weapons.iterator()) {
            meleeWeaponSerializer.fromData(data);
        }

        var rangedWeaponSerializer = new RangedWeaponSerializer(result.weapons, result.traits);
        for (data in data.ranged_weapons.iterator()) {
            rangedWeaponSerializer.fromData(data);
        }
    }

    public override function toData(result:CofDSystem):SystemData {
        return {
            version: CofDSystem.version,
            conditions: {},
            tilts: {},
            abilities: {},
            melee_weapons: {},
            ranged_weapons: {},
            armor: {},
            weapon_tags: {},
        }
    }

    public override function fromData(data:SystemData):CofDSystem {
        var cofdsystem = new CofDSystem();
        this.updateWithData(cofdsystem, data);
        return cofdsystem;
    }
}