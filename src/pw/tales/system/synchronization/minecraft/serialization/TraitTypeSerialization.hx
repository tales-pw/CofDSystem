package pw.tales.system.synchronization.minecraft.serialization;

import pw.tales.system.game_object.traits.TraitType;

typedef TraitTypeData = {
    dn:String,
    name:Null<String>
}

class TraitTypeSerialization {
    public static function serialize(traitType:TraitType<Dynamic>):TraitTypeData {
        return {
            dn: traitType.getDN(),
            name: traitType.getName()
        }
    }
}
