package pw.tales.cofdsystem.synchronization.serialization.system.parts;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon_melee.prefabs.MeleeWeaponPrefab;

typedef ApiMeleeWeapon = {
    dn:String,
    name:Null<String>,
    damage:Int,
    initiative:Int,
    strength:Int,
    size:Int,
    tags:Array<String>,
    categories:Array<String>
}

@:expose("MeleeSerialization")
class MeleeSerialization extends WeaponSerialization<ApiMeleeWeapon, MeleeWeaponPrefab>
{
    public static final INSTANCE = new MeleeSerialization();

    private override function getWeaponsData(data:Dynamic):DynamicAccess<ApiMeleeWeapon>
    {
        return data.melee_weapons;
    }

    private override function create(
        record:ApiMeleeWeapon,
        tags:Array<TraitType<Dynamic>>
    ):MeleeWeaponPrefab
    {
        final weapon:MeleeWeaponPrefab = {
            dn: record.dn,
            name: record.name,
            initiative: record.initiative,
            damage: record.damage,
            size: record.size,
            strength: record.strength,
            tags: tags
        };

        return weapon;
    }
}
