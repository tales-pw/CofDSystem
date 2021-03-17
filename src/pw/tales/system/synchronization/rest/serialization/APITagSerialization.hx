package pw.tales.system.synchronization.rest.serialization;

import haxe.DynamicAccess;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.synchronization.rest.ISerialization;
import pw.tales.system.weapon.traits.weapon_tags.WeaponTag;

typedef ApiWeaponTag = {
    dn:String,
    name:String,
    categories:Array<String>
}

class APITagSerialization implements ISerialization {
    public static final INSTANCE:APITagSerialization = new APITagSerialization();

    public function new() {}

    public function handle(system:CofDSystem, data:Dynamic) {
        var weaponTag:DynamicAccess<ApiWeaponTag> = data.weapon_tags;
        for (dn in weaponTag.keys()) {
            var record = weaponTag.get(dn);

            var type:TraitType<WeaponTag> = cast(system.traits.getRecord(dn));
            if (type == null) {
                type = new TraitType<WeaponTag>(dn);
                system.traits.register(type);
            }

            type.setName(record.name);
        }
    }
}
