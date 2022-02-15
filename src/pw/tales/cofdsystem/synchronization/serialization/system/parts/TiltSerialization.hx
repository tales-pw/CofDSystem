package pw.tales.cofdsystem.synchronization.serialization.system.parts;

import pw.tales.cofdsystem.character.traits.tilts.Tilt;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import haxe.DynamicAccess;

typedef ApiTilt = {
    dn:String,
    name:String,
    categories:Array<String>
}

@:expose("APITiltSerialization")
class TiltSerialization implements IPartSerialization
{
    public static final INSTANCE = new TiltSerialization();

    public function new() {}

    public function update(system:CofDSystem, data:Dynamic):Void
    {
        var tilts:DynamicAccess<ApiTilt> = data.tilts;
        for (dn in tilts.keys())
        {
            var record = tilts.get(dn);

            var type = cast(system.traits.getRecord(dn));
            if (type == null)
            {
                type = TraitType.createType(dn, Tilt.new);
                type.setTags(record.categories);
                system.traits.register(type);
            }

            type.setName(record.name);
        }
    }
}
