package pw.tales.cofdsystem.synchronization.rest.serialization;

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

class APIArmorSerialization implements ISerialization
{
    public static final INSTANCE:APIArmorSerialization = new APIArmorSerialization();

    public function new() {}

    public function handle(system:CofDSystem, data:Dynamic):Void
    {
        var armors:DynamicAccess<ApiArmor> = cast(data.armor);

        for (dn in armors.keys())
        {
            var record:ApiArmor = armors.get(dn);
            var armor = new ArmorPrefab(dn, record.name, record.general_armor, record.ballistic_armor, record.defense, record.speed, record.strength);

            system.armors.register(armor);
        }
    }
}
