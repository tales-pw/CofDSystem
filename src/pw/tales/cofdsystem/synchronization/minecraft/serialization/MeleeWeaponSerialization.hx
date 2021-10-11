package pw.tales.cofdsystem.synchronization.minecraft.serialization;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.prefabs.WeaponPrefab;
import pw.tales.cofdsystem.weapon_melee.prefabs.MeleeWeaponPrefab;

typedef MeleeWeaponData = {
    type:String,
    dn:String,
    name:Null<String>,
    initiative:Int,
    damage:Int,
    size:Int,
    tags:Array<String>
}

class MeleeWeaponSerialization
{
    public static final TYPE:String = "MELEE";

    public static function serialize(weapon:WeaponPrefab):MeleeWeaponData
    {
        return {
            type: MeleeWeaponSerialization.TYPE,
            dn: weapon.getDN(),
            name: weapon.getName(),
            initiative: weapon.getInitiativeMod(),
            damage: weapon.getDamageMod(),
            size: weapon.getSize(),
            tags: [for (tag in weapon.getWeaponTags()) tag.getDN()]
        };
    }

    public static function deserialize(tagRegistry:TraitTypeRegistry, data:MeleeWeaponData):WeaponPrefab
    {
        var tags:Array<TraitType<Dynamic>> = [];
        for (dn in data.tags)
        {
            var record = tagRegistry.getRecord(dn);
            if (record == null)
                throw 'Tag not found ${dn}';
            tags.push(record);
        }

        return new MeleeWeaponPrefab(data.dn, data.name, data.initiative, data.damage, data.size, tags);
    }
}
