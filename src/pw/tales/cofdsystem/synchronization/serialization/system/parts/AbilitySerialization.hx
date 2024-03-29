package pw.tales.cofdsystem.synchronization.serialization.system.parts;

import haxe.DynamicAccess;
import pw.tales.cofdsystem.character.traits.merits.MeritType;
import pw.tales.cofdsystem.parser.exception.ParsingException;
import pw.tales.cofdsystem.parser.parsers.DotsLevelsParser;
import pw.tales.cofdsystem.parser.parsers.RequirementsParser;
import pw.tales.cofdsystem.utils.logger.LoggerManager;

typedef ApiAbility = {
    dn:String,
    name:String,
    categories:Array<String>,
    cost:Int,
    levels:String,
    requirements:Array<String>
}

@:expose("AbilitySerialization")
class AbilitySerialization implements IPartSerialization
{
    public static final INSTANCE = new AbilitySerialization();

    private final requirementsParser:RequirementsParser = new RequirementsParser();
    private final levelsParser:DotsLevelsParser = new DotsLevelsParser();

    public function new() {}

    public function update(system:CofDSystem, data:Dynamic):Void
    {
        var abilities:DynamicAccess<ApiAbility> = data.abilities;

        var logger = LoggerManager.getLogger();
        for (dn in abilities.keys())
        {
            var record = abilities.get(dn);

            var abilityType:MeritType = cast(system.traits.getRecord(dn));
            if (abilityType == null)
            {
                abilityType = new MeritType(dn);
                system.traits.register(abilityType);
            }

            var tags = abilityType.getTags();
            tags.pushMany(record.categories);
            tags.push("ability");

            if (record.name != null)
                abilityType.setName(record.name);

            var requirementsArray:Array<Dynamic> = record.requirements;
            for (requirementsRaw in requirementsArray)
            {
                var requirements = requirementsParser.parse(requirementsRaw);
                abilityType.addRequirements(requirements);
            }

            try
            {
                if (record.levels != null)
                {
                    var levels = levelsParser.parse(record.levels);
                    abilityType.setLevels(levels);
                }
            } catch (e:ParsingException)
            {
                logger.warning(
                    'Error occured while parsing requitements for ${dn}: ${e.getError()}'
                );
            }
        }
    }
}
