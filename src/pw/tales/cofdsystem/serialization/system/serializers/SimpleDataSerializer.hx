package pw.tales.cofdsystem.serialization.system.serializers;

import pw.tales.cofdsystem.utils.registry.Registry;
import pw.tales.cofdsystem.CofDSystem;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.serialization.system.SystemData;
import thx.error.AbstractMethod;

class SimpleDataSerializer extends SystemSubSerializer<SimpleData, TraitType<Dynamic>>
{
    public function new(system:CofDSystem)
    {
        super(system);
    }

    public override function updateWithData(result:TraitType<Dynamic>, data:SimpleData):Void
    {
        result.setName(data.name);
    }

    public override function toData(result:TraitType<Dynamic>):SimpleData
    {
        return {
            dn: result.getDN(),
            name: result.getName(),
        }
    }

    public override function fromData(data:SimpleData):TraitType<Dynamic>
    {
        var record = this.create(data);
        this.updateWithData(record, data);
        return record;
    }

    private override function getRegistry():Registry<TraitType<Dynamic>>
    {
        return this.system.traits;
    }

    private function create(data:SimpleData):TraitType<Dynamic>
        throw new AbstractMethod();
}
