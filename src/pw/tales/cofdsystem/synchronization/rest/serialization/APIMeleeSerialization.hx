package pw.tales.cofdsystem.synchronization.rest.serialization;

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

class APIMeleeSerialization implements ISerialization {
    public static final INSTANCE:APIMeleeSerialization = new APIMeleeSerialization();

    public function new() {}

    public function handle(system:CofDSystem, data:Dynamic) {
        var melee_weapons:DynamicAccess<ApiMeleeWeapon> = data.melee_weapons;
        for (dn in melee_weapons.keys()) {
            var record = melee_weapons.get(dn);

            var tags:Array<TraitType<Dynamic>> = [];
            for (tagDN in record.tags) {
                var tag = system.traits.getRecord(tagDN);
                if (tag != null) tags.push(tag);
            }

            system.weapons.register(new MeleeWeaponPrefab(record.dn, record.name, record.initiative, record.damage, tags));
        }
    }
}