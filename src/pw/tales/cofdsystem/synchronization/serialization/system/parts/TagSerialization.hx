package pw.tales.cofdsystem.synchronization.serialization.system.parts;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.WeaponTag;

typedef ApiWeaponTag = {
    dn:String,
    name:String,
    categories:Array<String>
}

@:expose("APITagSerialization")
class TagSerialization implements IPartSerialization
{
    public static final INSTANCE = new TagSerialization();

    public function new() {}

    public function update(system:CofDSystem, data:Dynamic):Void
    {
        var weaponTag:DynamicAccess<ApiWeaponTag> = data.weapon_tags;
        for (dn in weaponTag.keys())
        {
            var record = weaponTag.get(dn);

            var type:TraitType<WeaponTag> = cast(system.traits.getRecord(dn));
            if (type == null)
            {
                type = TraitType.createType(dn, WeaponTag.new);

                var tags = type.getTags();
                tags.pushMany(record.categories);
                tags.push("weapon_tag");

                system.traits.register(type);
            }

            type.setName(record.name);
        }
    }
}
