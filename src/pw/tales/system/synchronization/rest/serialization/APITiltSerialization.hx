package pw.tales.system.synchronization.rest.serialization;

import haxe.DynamicAccess;
import pw.tales.system.character.traits.tilts.TiltType;
import pw.tales.system.synchronization.rest.ISerialization;

typedef ApiTilt = {
    dn:String,
    name:String,
    categories:Array<String>
}

class APITiltSerialization implements ISerialization {
    public static final INSTANCE:APITiltSerialization = new APITiltSerialization();

    public function new() {}

    public function handle(system:CofDSystem, data:Dynamic) {
        var tilts:DynamicAccess<ApiTilt> = data.tilts;
        for (dn in tilts.keys()) {
            var record = tilts.get(dn);

            var type:TiltType = cast(system.traits.getRecord(dn));
            if (type == null) {
                type = new TiltType(dn);
                system.traits.register(type);
            }

            type.setName(record.name);
        }
    }
}
