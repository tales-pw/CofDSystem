package pw.tales.system.synchronization.rest.serialization;

import haxe.DynamicAccess;
import pw.tales.system.character.traits.condition.Condition;
import pw.tales.system.game_object.traits.TraitType;

typedef ApiCondition = {
    dn:String,
    name:String,
    categories:Array<String>
}

class APIConditionSerialization implements ISerialization {
    public static final INSTANCE:APIConditionSerialization = new APIConditionSerialization();

    public function new() {}

    public function handle(system:CofDSystem, data:Dynamic) {
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
}
