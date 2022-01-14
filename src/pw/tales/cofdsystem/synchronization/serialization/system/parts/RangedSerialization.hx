package pw.tales.cofdsystem.synchronization.serialization.system.parts;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon_ranged.prefabs.RangedWeaponPrefab;

typedef ApiRangedWeapon = {
    dn:String,
    name:Null<String>,
    damage:Int,
    initiative:Int,
    strength:Int,
    size:Int,
    tags:Array<String>,
    categories:Array<String>
}

@:expose("RangedSerialization")
class RangedSerialization extends WeaponSerialization<ApiRangedWeapon, RangedWeaponPrefab>
{
    public static final INSTANCE = new RangedSerialization();

    private override function getWeaponsData(data:Dynamic):DynamicAccess<ApiRangedWeapon>
    {
        return data.ranged_weapons;
    }

    private override function create(
        record:ApiRangedWeapon,
        tags:Array<TraitType<Dynamic>>
    ):RangedWeaponPrefab
    {
        var weapon:RangedWeaponPrefab = {
            dn: record.dn,
            name: record.name,
            initiative: record.initiative,
            damage: record.damage,
            size: record.size,
            strength: record.strength,
            tags: tags
        }

        return weapon;
    }
}
