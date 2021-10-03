package pw.tales.cofdsystem.action.opposition.builder;

import pw.tales.cofdsystem.action.opposition.base.OppositionCompetitive;
import pw.tales.cofdsystem.action.opposition.pool.builder.ActionPoolBuilder;
import pw.tales.cofdsystem.action.opposition.base.Opposition;
import pw.tales.cofdsystem.action.opposition.Contested;
import pw.tales.cofdsystem.action.opposition.Resisted;
import pw.tales.cofdsystem.action.opposition.Simple;
import pw.tales.cofdsystem.common.EnumSide;
import pw.tales.cofdsystem.game_object.GameObject;

class CompetitionBuilder
{
    private final actorPoolBuilder:ActionPoolBuilder;
    private final targetPoolBuilder:ActionPoolBuilder;

    private var oppositionType:EnumCompetition = EnumCompetition.CONTESTED;

    public function new(actorPoolBuilder:ActionPoolBuilder, targetPoolBuilder:ActionPoolBuilder)
    {
        this.actorPoolBuilder = actorPoolBuilder;
        this.targetPoolBuilder = targetPoolBuilder;
    }

    public function getPoolBuilder(side:EnumSide):ActionPoolBuilder
    {
        if (side == EnumSide.ACTOR)
            return this.actorPoolBuilder;

        if (side == EnumSide.TARGET)
            return this.targetPoolBuilder;

        throw "Unknown side.";
    }

    public function setModifier(side:EnumSide, modifier:Int):CompetitionBuilder
    {
        var poolBuilder = this.getPoolBuilder(side);
        poolBuilder.setModifier(modifier);
        return this;
    }

    public function setTraits(side:EnumSide, traits:Array<String>):CompetitionBuilder
    {
        var poolBuilder = this.getPoolBuilder(side);
        poolBuilder.setTraits(traits);
        return this;
    }

    public function setOppositionType(opposition:EnumCompetition):CompetitionBuilder
    {
        this.oppositionType = opposition;
        return this;
    }

    private function createSimple():Simple
    {
        var actorRoll = this.actorPoolBuilder.build();
        var opposition:Simple = new Simple(actorRoll, 0);
        return opposition;
    }

    public function build():OppositionCompetitive
    {
        var obj:OppositionCompetitive;

        var actorRoll = this.actorPoolBuilder.build();
        var targetRoll = this.targetPoolBuilder.build();

        switch this.oppositionType
        {
            case EnumCompetition.RESISTED:
                obj = new Resisted(actorRoll, targetRoll);
            case EnumCompetition.CONTESTED:
                obj = new Contested(actorRoll, targetRoll);
        }

        return obj;
    }

    public static function create(actor:GameObject, target:GameObject):CompetitionBuilder
    {
        var actorPoolBuilder = new ActionPoolBuilder(actor);
        var targetPoolBuilder = new ActionPoolBuilder(target);
        return new CompetitionBuilder(actorPoolBuilder, targetPoolBuilder);
    }
}
