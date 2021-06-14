package pw.tales.cofdsystem.synchronization.system.serialization;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.WeaponTag;


class TagSerialization extends ABCTraitSerialization {
    public static final INSTANCE:TagSerialization = new TagSerialization();

    public function new() {}

    override private function getStorageDict(data:Dynamic):DynamicAccess<TraitDictItem> {
        return data.weapon_tags;
    }

    override private function addStorageDict(data:Dynamic):DynamicAccess<TraitDictItem> {
        return data.weapon_tags = {};
    }

    override private function filterType(trait:TraitType<Dynamic>):Bool {
        return Std.isOfType(trait, WeaponTag);
    }

    override private function ensureType(system:CofDSystem, dn:String):TraitType<Dynamic> {
        var type = cast(system.traits.getRecord(dn));
        if (type == null) {
            type = new WeaponTag(dn);
            system.traits.register(type);
        }
        return type;
    }
}
