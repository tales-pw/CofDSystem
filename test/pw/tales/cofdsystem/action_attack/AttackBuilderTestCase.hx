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

        c1.getTrait(Attributes.STRENGTH).setValue(3);
        c1.getTrait(Skills.BRAWL).setValue(2);

        c2.getTrait(Attributes.DEXTERITY).setValue(1);
        c2.getTrait(Attributes.WITS).setValue(1);
        c2.getTrait(Skills.ATHLETICS).setValue(0);
    }

    public function testSimple() {
        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        var health:HealthAdvantage = cast c2.getTrait(HealthAdvantage.TYPE);
        assertEquals(4, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());
    }

    public function testWillpowerActor() {
        var action = new AttackBuilder(c1, c2).spendWillpower(EnumSide.ACTOR).build();
        system.act(action);

        var health:HealthAdvantage = cast c2.getTrait(HealthAdvantage.TYPE);
        assertEquals(5, health.getBashing());
        assertEquals(1, health.getLethal());
        assertEquals(0, health.getAggravated());

        var willpower:WillpowerAdvantage = cast c1.getTrait(WillpowerAdvantage.TYPE);
        assertEquals(1, willpower.getPoints());
        assertEquals(2, willpower.getValue());

        var willpower:WillpowerAdvantage = cast c2.getTrait(WillpowerAdvantage.TYPE);
        assertEquals(2, willpower.getPoints());
        assertEquals(2, willpower.getValue());
    }

    public function testWillpowerTarget() {
        var action = new AttackBuilder(c1, c2).spendWillpower(EnumSide.TARGET).build();
        system.act(action);

        var health:HealthAdvantage = cast c2.getTrait(HealthAdvantage.TYPE);
        assertEquals(2, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());

        var willpower:WillpowerAdvantage = cast c1.getTrait(WillpowerAdvantage.TYPE);
        assertEquals(2, willpower.getPoints());
        assertEquals(2, willpower.getValue());

        var willpower:WillpowerAdvantage = cast c2.getTrait(WillpowerAdvantage.TYPE);
        assertEquals(1, willpower.getPoints());
        assertEquals(2, willpower.getValue());
    }

    public function testWillpowerBoth() {
        var action = new AttackBuilder(c1, c2)
        .spendWillpower(EnumSide.TARGET)
        .spendWillpower(EnumSide.ACTOR)
        .build();

        system.act(action);

        var health:HealthAdvantage = cast c2.getTrait(HealthAdvantage.TYPE);
        assertEquals(5, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());

        var willpower:WillpowerAdvantage = cast c1.getTrait(WillpowerAdvantage.TYPE);
        assertEquals(1, willpower.getPoints());
        assertEquals(2, willpower.getValue());

        var willpower:WillpowerAdvantage = cast c2.getTrait(WillpowerAdvantage.TYPE);
        assertEquals(1, willpower.getPoints());
        assertEquals(2, willpower.getValue());
    }

    public function testIsRelated() {
        var build = new AttackBuilder(c1, c2);
        assertTrue(build.isRelated(c1));
        assertTrue(build.isRelated(c2));
        assertFalse(build.isRelated(c3));
    }
}