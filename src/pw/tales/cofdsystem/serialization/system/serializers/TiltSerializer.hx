package pw.tales.cofdsystem.serialization.system.serializers;

import pw.tales.cofdsystem.character.traits.tilts.TiltType;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.serialization.system.SystemData;

class TiltSerializer extends SimpleDataSerializer
{
    public override function create(data:SimpleData):TraitType<Dynamic>
    {
        return new TiltType(data.dn);
    }
}
