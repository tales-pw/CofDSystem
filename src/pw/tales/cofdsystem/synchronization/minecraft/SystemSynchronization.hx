package pw.tales.cofdsystem.synchronization.minecraft;

import pw.tales.cofdsystem.serialization.system.SystemData;
import pw.tales.cofdsystem.serialization.system.SystemSerializer;

@:nullSafety(Off)
@:expose("SystemSynchronization")
class SystemSynchronization
{
    private static final systemSerializer = new SystemSerializer();

    // Things serializer needs to know
    public var system:CofDSystem = null;

    private function new(system:CofDSystem)
    {
        this.system = system;
    }

    public static function create(s:CofDSystem):SystemSynchronization
    {
        return new SystemSynchronization(s);
    }

    public function fromData(deserialized:SystemData):SystemSynchronization
    {
        this.system = systemSerializer.fromData(deserialized);
        return this;
    }

    public function toData():SystemData
    {
        return systemSerializer.toData(this.system);
    }

    public function deserialize(serializedData:String):SystemSynchronization
    {
        this.system = systemSerializer.deserialize(serializedData);
        return this;
    }

    public function serialize():String
    {
        return systemSerializer.serialize(this.system);
    }
}
