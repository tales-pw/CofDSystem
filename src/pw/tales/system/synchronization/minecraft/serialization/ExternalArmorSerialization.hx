package pw.tales.system.synchronization.minecraft.serialization;

import pw.tales.system.armor.prefabs.ArmorPrefab;

typedef ExternalArmorData = {
    dn:String,
    name:Null<String>,

    ballistic:Int,
    general:Int,

    defenceMod:Int,
    speedMod:Int,
    strengthReq:Int
}

class ExternalArmorSerialization {
    public static function serialize(armor:ArmorPrefab):ExternalArmorData {
        return {
            dn: armor.getDN(),
            name: armor.getName(),

            ballistic: armor.getBallistic(),
            general: armor.getGeneral(),
            defenceMod: armor.getDefenceMod(),
            speedMod: armor.getSpeedMod(),
            strengthReq: armor.getStrengthReq()
        };
    }

    public static function deserialize(data:ExternalArmorData):ArmorPrefab {
        return new ArmorPrefab(data.dn, data.name, data.general, data.ballistic, data.defenceMod, data.speedMod,
        data.strengthReq);
    }
}
