package pw.tales.cofdsystem.serialization.system;

import pw.tales.cofdsystem.serialization.system.serializers.ArmorSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.RangedWeaponSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.MeleeWeaponSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.AbilitySerializer;
import pw.tales.cofdsystem.serialization.system.serializers.ConditionSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.TiltSerializer;
import pw.tales.cofdsystem.serialization.system.serializers.WeaponTagSerializer;
import pw.tales.cofdsystem.serialization.system.SystemData;

class SystemSerializer extends Serializer<SystemData, CofDSystem>
{
    public function new()
    {
        super();
    }

    public override function updateWithData(result:CofDSystem, data:SystemData):Void
    {
        new ConditionSerializer(result).load(data.conditions);
        new TiltSerializer(result).load(data.tilts);
        new AbilitySerializer(result).load(data.abilities);
        new WeaponTagSerializer(result).load(data.weapon_tags);
        new MeleeWeaponSerializer(result).load(data.melee_weapons);
        new RangedWeaponSerializer(result).load(data.ranged_weapons);
    }

    public override function toData(result:CofDSystem):SystemData
    {
        return {
            version: CofDSystem.version,
            conditions: new ConditionSerializer(result).dump(),
            tilts: new TiltSerializer(result).dump(),
            abilities: new AbilitySerializer(result).dump(),
            melee_weapons: new MeleeWeaponSerializer(result).dump(),
            ranged_weapons: new RangedWeaponSerializer(result).dump(),
            armor: new ArmorSerializer(result).dump(),
            weapon_tags: new WeaponTagSerializer(result).dump(),
        }
    }

    public override function fromData(data:SystemData):CofDSystem
    {
        var cofdsystem = new CofDSystem();
        this.updateWithData(cofdsystem, data);
        return cofdsystem;
    }
}
