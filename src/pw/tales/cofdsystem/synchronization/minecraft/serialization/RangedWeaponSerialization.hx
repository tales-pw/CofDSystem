package pw.tales.cofdsystem.synchronization.minecraft.serialization;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.weapon_ranged.prefabs.RangedWeaponPrefab;

typedef RangedWeaponData = {
    type:String,
    dn:String,
    name:Null<String>,
    initiative:Int,
    damage:Int,
    tags:Array<String>
}

class RangedWeaponSerialization
{
    public static final TYPE:String = "RANGED";

    public static function serialize(weapon:WeaponPrefab):RangedWeaponData
    {
        return {
            type: RangedWeaponSerialization.TYPE,
            dn: weapon.getDN(),
            name: weapon.getName(),
            initiative: weapon.getInitiativeMod(),
            damage: weapon.getDamageMod(),
            tags: [for (tag in weapon.getWeaponTags()) tag.getDN()]
        };
    }

    public static function deserialize(tagRegistry:TraitTypeRegistry, data:RangedWeaponData):RangedWeaponPrefab
    {
        var tags:Array<TraitType<Dynamic>> = [];
        for (dn in data.tags)
        {
            var record = tagRegistry.getRecord(dn);
            if (record == null)
                throw 'Tag not found ${dn}';
            tags.push(record);
        }

        return new RangedWeaponPrefab(data.dn, data.name, data.initiative, data.damage, tags);
    }
}
