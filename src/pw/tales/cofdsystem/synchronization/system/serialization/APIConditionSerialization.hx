package pw.tales.cofdsystem.synchronization.system.serialization;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.character.traits.condition.Condition;
import pw.tales.cofdsystem.game_object.traits.TraitType;

typedef ApiCondition = {
    dn:String,
    name:String,
    categories:Array<String>
}

class APIConditionSerialization implements ISystemSerializationItem {
    public static final INSTANCE:APIConditionSerialization = new APIConditionSerialization();

    public function new() {}

    public function updateFromData(system:CofDSystem, data:Dynamic) {
        var conditions:DynamicAccess<ApiCondition> = data.conditions;
        for (dn in conditions.keys()) {
            var record = conditions.get(dn);

            var type:TraitType<Condition> = cast(system.traits.getRecord(dn));
            if (type == null) {
                type = new TraitType<Condition>(dn);
                system.traits.register(type);
            }

            type.setName(record.name);
        }
    }

    public function writeToData(system:CofDSystem, data:Dynamic):Void {
    }
}
