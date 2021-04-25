package pw.tales.cofdsystem.action_attack.builder;

import pw.tales.cofdsystem.action.IAction;
import pw.tales.cofdsystem.action.modifications.Offhand;
import pw.tales.cofdsystem.action.modifications.Willpower;
import pw.tales.cofdsystem.action.opposition.base.OppositionCompetitive;
import pw.tales.cofdsystem.action.opposition.builder.EnumOpposition;
import pw.tales.cofdsystem.action.opposition.builder.OppositionBuilder;
import pw.tales.cofdsystem.action_attack.modifications.AllOutAttack;
import pw.tales.cofdsystem.action_attack.modifications.SpecifiedTarget;
import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.common.EnumSide;
import pw.tales.cofdsystem.game_object.GameObject;

class AttackBuilder {
    private final system:CofDSystem;

    private var specifiedTarget:Null<EnumSpecifiedTarget> = null;

    private final actor:GameObject;
    private var actorAllOut = false;
    private var actorWillpower = false;
    private var actorHand = EnumHand.HAND;
    private var actorModifier = 0;

    private final target:GameObject;
    private var targetWillpower = false;
    private var targetHand = EnumHand.HAND;
    private var targetResistType = EnumResistType.DEFAULT;
    private var targetModifier = 0;

    public function new(actor:GameObject, target:GameObject) {
        this.system = actor.getSystem();
        this.actor = actor;
        this.target = target;
    }

    public function getActor() {
        return this.actor;
    }

    public function getTarget() {
        return this.target;
    }

    public function setAllOut(allOut:Bool) {
        this.actorAllOut = allOut;
    }

    public function setTarget(specifiedTarget:EnumSpecifiedTarget) {
        this.specifiedTarget = specifiedTarget;
    }

    public function setModifier(side:EnumSide, value:Int) {
        switch (side) {
            case EnumSide.ACTOR:
                this.actorModifier = value;
            case EnumSide.TARGET:
                this.targetModifier = value;
        }
        return this;
    }

    public function spendWillpower(side:EnumSide, value:Bool = true):AttackBuilder {
        switch (side) {
            case EnumSide.ACTOR:
                this.actorWillpower = value;
            case EnumSide.TARGET:
                this.targetWillpower = value;
        }
        return this;
    }

    public function setHand(side:EnumSide, hand:EnumHand):AttackBuilder {
        switch (side) {
            case EnumSide.ACTOR:
                this.actorHand = hand;
            case EnumSide.TARGET:
                this.targetHand = hand;
        }
        return this;
    }

    public function setResist(resistType:EnumResistType):AttackBuilder {
        this.targetResistType = resistType;
        return this;
    }

    public function createOpposition():OppositionCompetitive {
        var oppositionBuilder = new OppositionBuilder();
        oppositionBuilder.setActor(actor);
        oppositionBuilder.setTarget(target);

        oppositionBuilder.setTraits(EnumSide.ACTOR, [Attributes.STRENGTH.getDN(), Skills.BRAWL.getDN()]);

        switch (targetResistType) {
            case EnumResistType.DEFAULT:
                oppositionBuilder.setOppositionType(EnumOpposition.RESISTED);
                oppositionBuilder.setTraits(EnumSide.TARGET, [DefenceAdvantage.DN]);
            case EnumResistType.NO_DEFENCE:
                oppositionBuilder.setOppositionType(EnumOpposition.RESISTED);
                oppositionBuilder.setTraits(EnumSide.TARGET, []);
            case EnumResistType.DODGE:
                oppositionBuilder.setOppositionType(EnumOpposition.CONTESTED);
                oppositionBuilder.setTraits(EnumSide.TARGET, [DefenceAdvantage.DN, DefenceAdvantage.DN]);
        }

        if (this.actorModifier != 0) {
            oppositionBuilder.setModifier(EnumSide.ACTOR, this.actorModifier);
        }

        if (this.targetModifier != 0) {
            oppositionBuilder.setModifier(EnumSide.TARGET, this.targetModifier);
        }

        return cast(oppositionBuilder.build());
    }

    public function build():IAction {
        var opposition:OppositionCompetitive = this.createOpposition();

        var attackAction:AttackAction = new AttackAction(opposition, this.system);
        var action:IAction = attackAction;

        if (specifiedTarget != null) action.addModification(
            new SpecifiedTarget(specifiedTarget.getTarget())
        );

        if (actorAllOut) action.addModification(new AllOutAttack(actor));

        if (actorWillpower) action.addModification(new Willpower(actor));
        if (targetWillpower) action.addModification(new Willpower(target));

        if (actorHand == EnumHand.OFFHAND) action.addModification(new Offhand(actor));
        if (targetHand == EnumHand.OFFHAND) action.addModification(new Offhand(actor));

        return action;
    }
}