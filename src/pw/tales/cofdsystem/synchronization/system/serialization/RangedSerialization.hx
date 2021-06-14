package pw.tales.cofdsystem.synchronization.system.serialization;

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

class RangedSerialization implements ISystemSerializationItem {
    public static final INSTANCE:RangedSerialization = new RangedSerialization();

    public function new() {}

    public function updateFromData(system:CofDSystem, data:Dynamic) {
        var rangedWeapons:DynamicAccess<ApiRangedWeapon> = data.ranged_weapons;
        for (dn in rangedWeapons.keys()) {
            var record = rangedWeapons.get(dn);

            var tags:Array<TraitType<Dynamic>> = [];
            for (tagDN in record.tags) {
                var tag = system.traits.getRecord(tagDN);
                if (tag != null) tags.push(tag);
            }

            system.weapons.register(new RangedWeaponPrefab(record.dn, record.name, record.initiative, record.damage, tags));
        }
    }

    public function writeToData(system:CofDSystem, data:Dynamic):Void {

    }
}