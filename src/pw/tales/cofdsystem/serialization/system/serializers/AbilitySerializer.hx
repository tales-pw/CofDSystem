package pw.tales.cofdsystem.serialization.system.serializers;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.character.traits.merits.MeritType;
import pw.tales.cofdsystem.parser.exception.ParsingException;
import pw.tales.cofdsystem.parser.parsers.DotsLevelsParser;
import pw.tales.cofdsystem.parser.parsers.RequirementsParser;
import pw.tales.cofdsystem.serialization.system.SystemData;
import pw.tales.cofdsystem.utils.logger.LoggerManager;
import pw.tales.cofdsystem.utils.registry.Registry;

class AbilitySerializer extends SystemSubSerializer<AbilityData, MeritType> {
    private static final requirementsParser = new RequirementsParser();
    private static final levelsParser = new DotsLevelsParser();

    public function new(system: CofDSystem) {
        super(system);
    }

    public override function updateWithData(result:MeritType, data:AbilityData):Void {
        var logger = LoggerManager.getLogger();

        if (data.name != null) result.setName(data.name);
        if (data.cost != null) result.setDotCost(data.cost);

        var requirementsArray = data.requirements;
        for (requirementsRaw in requirementsArray) {
            var requirements = requirementsParser.parse(requirementsRaw);
            result.addRequirements(requirements);
        }

        try {
            if (data.levels != null) {
                var levels = levelsParser.parse(data.levels);
                result.setLevels(levels);
            }
        } catch (e:ParsingException) {
            logger.warning('Error occured while parsing requitements for ${data.dn}: ${e.getError()}');
        }
    }

    public override function toData(result:MeritType):AbilityData {
        var requirementsSerialized = [];
        var requirements = result.getRequirements();

        if (requirements != null) {
            requirementsSerialized = [requirements.serialize()];
        }

        return {
            dn: result.getDN(), name: result.getName(), cost: result.getDotCost(), levels: result.getLevels().serialize(), requirements: requirementsSerialized, };
    }

    public override function fromData(data:AbilityData):MeritType {
        var record = new MeritType(data.dn);
        this.updateWithData(record, data);
        return record;
    }

    private override function getRegistry(): Registry<MeritType> {
        return cast this.system.traits;
    }
}