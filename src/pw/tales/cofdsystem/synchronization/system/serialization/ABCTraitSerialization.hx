package pw.tales.cofdsystem.synchronization.system.serialization;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import thx.error.AbstractMethod;

typedef TraitDictItem = {
    dn:String,
    name:String,
    categories:Array<String>
}

class ABCTraitSerialization implements ISystemSerializationItem {
    public function new() {}

    private function getStorageDict(data:Dynamic):DynamicAccess<TraitDictItem> {
        throw new AbstractMethod();
    }

    private function addStorageDict(data:Dynamic):DynamicAccess<TraitDictItem> {
        throw new AbstractMethod();
    }

    private function filterType(trait:TraitType<Dynamic>):Bool {
        throw new AbstractMethod();
    }

    private function ensureType(system:CofDSystem, dn:String):TraitType<Dynamic> {
        throw new AbstractMethod();
    }

    public function updateFromData(system:CofDSystem, data:Dynamic) {
        var traitTypeDict = this.getStorageDict(data);
        for (dn in traitTypeDict.keys()) {
            var record = traitTypeDict.get(dn);
            var type = this.ensureType(system, dn);
            type.setName(record.name);
        }
    }

    public function writeToData(system:CofDSystem, data:Dynamic):Void {
        var tilts = this.addStorageDict(data);

        for (traitType in system.traits.items()) {
            if (!this.filterType(traitType)) continue;
            tilts.set(traitType.getDN(), {
                dn: traitType.getDN(),
                name:traitType.getDisplayName(),
                categories:[]
            });
        }
    }
}
