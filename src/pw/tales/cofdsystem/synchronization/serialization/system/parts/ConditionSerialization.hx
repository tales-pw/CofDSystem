package pw.tales.cofdsystem.synchronization.serialization.system.parts;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.character.traits.condition.Condition;
import pw.tales.cofdsystem.game_object.traits.TraitType;

typedef ApiCondition = {
    dn:String,
    name:String,
    categories:Array<String>
}

@:expose("ConditionSerialization")
class ConditionSerialization implements IPartSerialization
{
    public static final INSTANCE = new ConditionSerialization();

    public function new() {}

    public function update(system:CofDSystem, data:Dynamic):Void
    {
        var conditions:DynamicAccess<ApiCondition> = data.conditions;
        for (dn in conditions.keys())
        {
            var record = conditions.get(dn);

            var type:TraitType<Condition> = cast(system.traits.getRecord(dn));
            if (type == null)
            {
                type = TraitType.createType(dn, Condition.new);

                var tags = type.getTags();
                tags.pushMany(record.categories);
                tags.push("condition");

                system.traits.register(type);
            }

            type.setName(record.name);
        }
    }
}
