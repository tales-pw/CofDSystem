package pw.tales.cofdsystem.serialization.system.serializers;

import pw.tales.cofdsystem.character.traits.condition.Condition;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.serialization.system.SystemData;

class ConditionSerializer extends SimpleDataSerializer {
    public override function create(data:SimpleData):TraitType<Dynamic> {
        return TraitType.createType(data.dn, Condition.create);
    }
}