package pw.tales.cofdsystem.synchronization.serialization.system.parts;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.armor.prefabs.ArmorPrefab;

typedef ApiArmor = {
    dn:String,
    name:Null<String>,
    categories:Array<String>,
    strength:Int,
    speed:Int,
    general_armor:Int,
    ballistic_armor:Int,
    defense:Int,
    availability:String
}

@:expose("ArmorSerialization")
class ArmorSerialization implements IPartSerialization
{
    public static final INSTANCE = new ArmorSerialization();

    public function new() {}

    public function update(system:CofDSystem, data:Dynamic):Void
    {
        var armors:DynamicAccess<ApiArmor> = cast(data.armor);

        for (dn in armors.keys())
        {
            var record:ApiArmor = armors.get(dn);
            var armor:ArmorPrefab = {
                dn: dn,
                name: record.name,
                general: record.general_armor,
                ballistic: record.ballistic_armor,
                defenceMod: record.defense,
                speedMod: record.speed,
                strengthReq: record.strength
            };

            system.armors.register(armor);
        }
    }
}
