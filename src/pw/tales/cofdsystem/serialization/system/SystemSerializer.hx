package pw.tales.cofdsystem.serialization.system;

import pw.tales.cofdsystem.serialization.system.serializers.AbilitySerializer;
import pw.tales.cofdsystem.serialization.system.serializers.ConditionSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.TiltSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.WeaponTagSerializer;
import pw.tales.cofdsystem.serialization.system.SystemData;
import thx.error.AbstractMethod;

class SystemSerializer extends Serializer<SystemData, CofDSystem> {
    public override function updateWithData(result:CofDSystem, data:SystemData):Void {
        var conditionSerializer = new ConditionSerializer(result.traits);
        for (data in data.conditions) {
            conditionSerializer.fromData(data);
        }

        var tiltsSerializer = new TiltSerializer(result.traits);
        for (data in data.tilts) {
            tiltsSerializer.fromData(data);
        }

        var abilitySerializer = new AbilitySerializer(result.traits);
        for (data in data.abilities) {
            abilitySerializer.fromData(data);
        }

        var tagSerializer = new WeaponTagSerializer(result.traits);
        for (data in data.weapon_tags) {
            tagSerializer.fromData(data);
        }
    }

    public override function toData(result:CofDSystem):SystemData {
        throw new AbstractMethod();
    }

    public override function fromData(data:SystemData):CofDSystem {
        var cofdsystem = new CofDSystem();
        this.updateWithData(cofdsystem, data);
        return cofdsystem;
    }
}