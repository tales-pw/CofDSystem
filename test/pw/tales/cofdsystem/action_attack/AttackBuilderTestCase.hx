package pw.tales.cofdsystem.action_attack;

import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.character.traits.advantages.health.HealthAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.willpower.WillpowerAdvantage;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.common.EnumSide;

@:nullSafety(Off)
class AttackBuilderTestCase extends CofDSystemTestCase {
    override public function setup() {
        super.setup();

        c1.getTraitManager().getTrait(Attributes.STRENGTH).setValue(3);
        c1.getTraitManager().getTrait(Skills.BRAWL).setValue(2);

        c2.getTraitManager().getTrait(Attributes.DEXTERITY).setValue(1);
        c2.getTraitManager().getTrait(Attributes.WITS).setValue(1);
        c2.getTraitManager().getTrait(Skills.ATHLETICS).setValue(0);
    }

    public function testSimple() {
        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        var health:HealthAdvantage = cast c2.getTraitManager().getTrait(HealthAdvantage.TYPE);
        assertEquals(4, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());
    }

    public function testWillpowerActor() {
        var action = new AttackBuilder(c1, c2).spendWillpower(EnumSide.ACTOR).build();
        system.act(action);

        var health:HealthAdvantage = cast c2.getTraitManager().getTrait(HealthAdvantage.TYPE);
        assertEquals(5, health.getBashing());
        assertEquals(1, health.getLethal());
        assertEquals(0, health.getAggravated());

        var willpower:WillpowerAdvantage = cast c1.getTraitManager().getTrait(WillpowerAdvantage.TYPE);
        assertEquals(1, willpower.getPoints());
        assertEquals(2, willpower.getValue());

        var willpower:WillpowerAdvantage = cast c2.getTraitManager().getTrait(WillpowerAdvantage.TYPE);
        assertEquals(2, willpower.getPoints());
        assertEquals(2, willpower.getValue());
    }

    public function testWillpowerTarget() {
        var action = new AttackBuilder(c1, c2).spendWillpower(EnumSide.TARGET).build();
        system.act(action);

        var health:HealthAdvantage = cast c2.getTraitManager().getTrait(HealthAdvantage.TYPE);
        assertEquals(2, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());

        var willpower:WillpowerAdvantage = cast c1.getTraitManager().getTrait(WillpowerAdvantage.TYPE);
        assertEquals(2, willpower.getPoints());
        assertEquals(2, willpower.getValue());

        var willpower:WillpowerAdvantage = cast c2.getTraitManager().getTrait(WillpowerAdvantage.TYPE);
        assertEquals(1, willpower.getPoints());
        assertEquals(2, willpower.getValue());
    }

    public function testWillpowerBoth() {
        var action = new AttackBuilder(c1, c2)
        .spendWillpower(EnumSide.TARGET)
        .spendWillpower(EnumSide.ACTOR)
        .build();

        system.act(action);

        var health:HealthAdvantage = cast c2.getTraitManager().getTrait(HealthAdvantage.TYPE);
        assertEquals(5, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());

        var willpower:WillpowerAdvantage = cast c1.getTraitManager().getTrait(WillpowerAdvantage.TYPE);
        assertEquals(1, willpower.getPoints());
        assertEquals(2, willpower.getValue());

        var willpower:WillpowerAdvantage = cast c2.getTraitManager().getTrait(WillpowerAdvantage.TYPE);
        assertEquals(1, willpower.getPoints());
        assertEquals(2, willpower.getValue());
    }
}