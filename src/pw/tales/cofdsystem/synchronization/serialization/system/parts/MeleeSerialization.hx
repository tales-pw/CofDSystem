package pw.tales.cofdsystem.synchronization.serialization.system.parts;

import pw.tales.cofdsystem.synchronization.serialization.system.exceptions.ParsingError;
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
class MeleeSerialization implements IPartSerialization
{
    public static final INSTANCE = new MeleeSerialization();

    public function new() {}

    public function update(system:CofDSystem, data:Dynamic):Void
    {
        var melee_weapons:DynamicAccess<ApiMeleeWeapon> = data.melee_weapons;
        for (dn in melee_weapons.keys())
        {
            var record = melee_weapons.get(dn);

            var tags:Array<TraitType<Dynamic>> = [];
            for (tagDN in record.tags)
            {
                var tag = system.traits.getRecord(tagDN);

                if (tag == null)
                    throw new ParsingError(record.tags);

                tags.push(tag);
            }

            final weapon:MeleeWeaponPrefab = {
                dn: record.dn,
                name: record.name,
                initiative: record.initiative,
                damage: record.damage,
                size: record.size,
                strength: record.strength,
                tags: tags
            };

            system.weapons.register(weapon);
        }
    }
}
