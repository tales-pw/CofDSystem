package pw.tales.cofdsystem.action_attack.builder;

import pw.tales.cofdsystem.builder.exceptions.UnknownSideException;
import pw.tales.cofdsystem.action.competition.Competition;
import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.action.competition.builder.CompetitionBuilder;
import pw.tales.cofdsystem.action.competition.builder.EnumCompetition;
import pw.tales.cofdsystem.action_attack.builder.exceptions.NoWillpowerBuilderException;
import pw.tales.cofdsystem.character.traits.advantages.willpower.WillpowerAdvantage;
import pw.tales.cofdsystem.action.modifications.Offhand;
import pw.tales.cofdsystem.action.modifications.Willpower;
import pw.tales.cofdsystem.action_attack.modifications.AllOutAttack;
import pw.tales.cofdsystem.action_attack.modifications.SpecifiedTarget;
import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.common.EnumSide;
import pw.tales.cofdsystem.game_object.GameObject;

@:expose("AttackBuilder")
class AttackBuilder
{
    private final system:CofDSystem;
    private final competitionBuilder:CompetitionBuilder;

    private var specifiedTarget:Null<EnumSpecifiedTarget> = null;

    private final actor:GameObject;
    private var actorWillpower = false;
    private var actorHand = EnumHand.HAND;
    private var actorAllOut = false;

    private final target:GameObject;
    private var targetWillpower = false;
    private var targetHand = EnumHand.HAND;
    private var targetResistType = EnumResistType.DEFAULT;

    public function new(actor:GameObject, target:GameObject)
    {
        this.system = actor.getSystem();

        this.competitionBuilder = CompetitionBuilder.create(actor, target);
        this.competitionBuilder.setTraits(EnumSide.ACTOR, [Attributes.STRENGTH.getDN(), Skills.BRAWL.getDN()]);

        updateCompetitionResistType(this.competitionBuilder, this.targetResistType);

        this.actor = actor;
        this.target = target;
    }

    public function getActor():GameObject
    {
        return this.actor;
    }

    public function getTarget():GameObject
    {
        return this.target;
    }

    public function getGameObject(side:EnumSide):GameObject
    {
        switch (side)
        {
            case EnumSide.ACTOR:
                return this.getActor();
            case EnumSide.TARGET:
                return this.getTarget();
            default:
                throw new UnknownSideException();
        }
    }

    public function isRelated(gameObject:GameObject):Bool
    {
        return this.actor == gameObject || this.target == gameObject;
    }

    public function isAllOut():Bool
    {
        return this.actorAllOut;
    }

    public function setAllOut(allOut:Bool):AttackBuilder
    {
        this.actorAllOut = allOut;
        return this;
    }

    public function getExplode(side:EnumSide):EnumExplode
    {
        return this.competitionBuilder.getExplode(side);
    }

    public function setExplode(side:EnumSide, explode:EnumExplode):AttackBuilder
    {
        this.competitionBuilder.setExplode(side, explode);
        return this;
    }

    public function getSpecifiedTarget():Null<EnumSpecifiedTarget>
    {
        return this.specifiedTarget;
    }

    public function setSpecifiedTarget(specifiedTarget:EnumSpecifiedTarget):AttackBuilder
    {
        this.specifiedTarget = specifiedTarget;
        return this;
    }

    public function getModifier(side:EnumSide):Int
    {
        return this.competitionBuilder.getModifier(side);
    }

    public function setModifier(side:EnumSide, value:Int):AttackBuilder
    {
        this.competitionBuilder.setModifier(side, value);
        return this;
    }

    public function getSpendWillpower(side:EnumSide):Bool
    {
        switch (side)
        {
            case EnumSide.ACTOR:
                return this.actorWillpower;
            case EnumSide.TARGET:
                return this.targetWillpower;
            default:
                throw new UnknownSideException();
        }
    }

    public function setSpendWillpower(side:EnumSide, value:Bool = true):AttackBuilder
    {
        var gameObject = this.getGameObject(side);
        var willpower = gameObject.getTrait(WillpowerAdvantage.TYPE);

        if (willpower == null || !willpower.canUse())
        {
            throw new NoWillpowerBuilderException(this);
        }

        switch (side)
        {
            case EnumSide.ACTOR:
                this.actorWillpower = value;
            case EnumSide.TARGET:
                this.targetWillpower = value;
            default:
                throw new UnknownSideException();
        }

        return this;
    }

    public function getHand(side:EnumSide):EnumHand
    {
        switch (side)
        {
            case EnumSide.ACTOR:
                return this.actorHand;
            case EnumSide.TARGET:
                return this.targetHand;
            default:
                throw new UnknownSideException();
        }
    }

    public function setHand(side:EnumSide, hand:EnumHand):AttackBuilder
    {
        switch (side)
        {
            case EnumSide.ACTOR:
                this.actorHand = hand;
            case EnumSide.TARGET:
                this.targetHand = hand;
            default:
                throw new UnknownSideException();
        }
        return this;
    }

    public function getResistType():EnumResistType
    {
        return this.targetResistType;
    }

    public function setResistType(resistType:EnumResistType):AttackBuilder
    {
        this.targetResistType = resistType;

        updateCompetitionResistType(this.competitionBuilder, this.targetResistType);

        return this;
    }

    public function build():AttackAction
    {
        var competition:Competition = this.competitionBuilder.build();
        var action:AttackAction = new AttackAction(competition, this.system);

        // Add modification for specified attack
        if (specifiedTarget != null)
            action.addModification(new SpecifiedTarget(specifiedTarget.getTarget()));

        // Add all-out attack modification
        if (actorAllOut)
            action.addModification(new AllOutAttack(actor));

        // Add wilpower spend modification
        if (actorWillpower)
            action.addModification(new Willpower(actor));
        if (targetWillpower)
            action.addModification(new Willpower(target));

        // Add offhand modification
        if (actorHand == EnumHand.OFFHAND)
            action.addModification(new Offhand(actor));
        if (targetHand == EnumHand.OFFHAND)
            action.addModification(new Offhand(actor));

        return action;
    }

    private static function updateCompetitionResistType(builder:CompetitionBuilder, resist:EnumResistType):Void
    {
        switch (resist)
        {
            case EnumResistType.DEFAULT:
                builder.setOppositionType(EnumCompetition.RESISTED);
                builder.setTraits(EnumSide.TARGET, [DefenceAdvantage.DN]);
            case EnumResistType.NO_DEFENCE:
                builder.setOppositionType(EnumCompetition.RESISTED);
                builder.setTraits(EnumSide.TARGET, []);
            case EnumResistType.DODGE:
                builder.setOppositionType(EnumCompetition.CONTESTED);
                builder.setTraits(EnumSide.TARGET, [DefenceAdvantage.DN, DefenceAdvantage.DN]);
        }
    }
}
