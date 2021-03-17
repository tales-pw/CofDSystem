package pw.tales.system.synchronization.rest.serialization;

import haxe.DynamicAccess;
import pw.tales.system.character.traits.merits.MeritType;
import pw.tales.system.parser.exception.ParsingException;
import pw.tales.system.parser.parsers.DotsLevelsParser;
import pw.tales.system.parser.parsers.RequirementsParser;
import pw.tales.system.utils.logger.LoggerManager;

typedef ApiAbility = {
    dn:String,
    name:String,
    categories:Array<String>,
    cost:Int,
    levels:String,
    requirements:Array<String>
}

class APIAbilitySerialization implements ISerialization {
    public static final INSTANCE:APIAbilitySerialization = new APIAbilitySerialization();

    private final requirementsParser:RequirementsParser = new RequirementsParser();
    private final levelsParser:DotsLevelsParser = new DotsLevelsParser();

    public function new() {}

    public function handle(system:CofDSystem, data:Dynamic) {
        var abilities:DynamicAccess<ApiAbility> = data.abilities;

        var logger = LoggerManager.getLogger();
        for (dn in abilities.keys()) {
            var record = abilities.get(dn);

            var abilityType:MeritType = cast(system.traits.getRecord(dn));
            if (abilityType == null) {
                abilityType = new MeritType(dn);
                system.traits.register(abilityType);
            }

            if (record.name != null) abilityType.setName(record.name);

            var requirementsArray:Array<Dynamic> = record.requirements;
            for (requirementsRaw in requirementsArray) {
                var requirements = requirementsParser.parse(requirementsRaw);
                abilityType.addRequirements(requirements);
            }

            try {
                if (record.levels != null) {
                    var levels = levelsParser.parse(record.levels);
                    abilityType.setLevels(levels);
                }
            }
            catch (e:ParsingException) {
                logger.warning('Error occured while parsing requitements for ${dn}: ${e.getError()}');
            }
        }
    }
}
