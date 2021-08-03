package pw.tales.cofdsystem.serialization.system.serializers;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.serialization.system.SystemData;
import thx.error.AbstractMethod;

class SimpleDataSerializer extends Serializer<SimpleData, TraitType<Dynamic>> {
    private final registry:TraitTypeRegistry;

    public function new(registry:TraitTypeRegistry) {
        this.registry = registry;
    }

    public override function updateWithData(result:TraitType<Dynamic>, data:SimpleData):Void {
        result.setName(data.name);
    }

    public override function toData(result:TraitType<Dynamic>):SimpleData {
        return {
            dn: result.getDN(), name: result.getName(), }
    }

    public override function fromData(data:SimpleData):TraitType<Dynamic> {
        var record:Null<TraitType<Dynamic>> = cast registry.getRecord(data.dn);
        if (record == null) {
            record = this.create(data);
            registry.register(record);
        }
        this.updateWithData(record, data);
        return record;
    }

    public function create(data:SimpleData):TraitType<Dynamic> throw new AbstractMethod();
}