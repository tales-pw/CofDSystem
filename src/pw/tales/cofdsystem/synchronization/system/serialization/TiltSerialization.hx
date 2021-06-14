package pw.tales.cofdsystem.synchronization.system.serialization;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.character.traits.tilts.TiltType;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class TiltSerialization extends ABCTraitSerialization {
    public static final INSTANCE:TiltSerialization = new TiltSerialization();

    public function new() {}

    override private function getStorageDict(data:Dynamic):DynamicAccess<TraitDictItem> {
        return data.tilts;
    }

    override private function addStorageDict(data:Dynamic):DynamicAccess<TraitDictItem> {
        return data.tilts = {};
    }

    override private function filterType(trait:TraitType<Dynamic>):Bool {
        return Std.isOfType(trait, TiltType);
    }

    override private function ensureType(system:CofDSystem, dn:String):TraitType<Dynamic> {
        var type:TiltType = cast(system.traits.getRecord(dn));
        if (type == null) {
            type = new TiltType(dn);
            system.traits.register(type);
        }
        return type;
    }
}
