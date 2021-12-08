package pw.tales.cofdsystem.action_attack;

import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.character.traits.advantages.health.HealthAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.willpower.WillpowerAdvantage;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.common.EnumSide;

@:nullSafety(Off)
class AttackBuilderTestCase extends CofDSystemTestCase
{
    override public function setup():Void
    {
        super.setup();

        c1.getTrait(Attributes.STRENGTH).setValue(3);
        c1.getTrait(Skills.BRAWL).setValue(2);

        c2.getTrait(Attributes.DEXTERITY).setValue(1);
        c2.getTrait(Attributes.WITS).setValue(1);
        c2.getTrait(Skills.ATHLETICS).setValue(0);
    }

    public function testSimple():Void
    {
        var action = new AttackBuilder(c1, c2).build();
        action.execute();

        var health:HealthAdvantage = cast c2.getTrait(HealthAdvantage.TYPE);
        assertEquals(4, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());
    }

    public function testWillpowerActor():Void
    {
        var action = new AttackBuilder(c1, c2).setSpendWillpower(EnumSide.ACTOR).build();
        action.execute();

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

    public function testWillpowerTarget():Void
    {
        var action = new AttackBuilder(c1, c2).setSpendWillpower(EnumSide.TARGET).build();
        action.execute();

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

    public function testWillpowerBoth():Void
    {
        var action = new AttackBuilder(c1, c2).setSpendWillpower(EnumSide.TARGET).setSpendWillpower(EnumSide.ACTOR).build();

        action.execute();

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

    public function testIsRelated():Void
    {
        var build = new AttackBuilder(c1, c2);
        assertTrue(build.isRelated(c1));
        assertTrue(build.isRelated(c2));
        assertFalse(build.isRelated(c3));
    }

    private function methodTestExplode(actorExplode:EnumExplode, targetExplode:EnumExplode):Void
    {
        var action:AttackAction = new AttackBuilder(c1, c2).setExplode(EnumSide.ACTOR, actorExplode).setExplode(EnumSide.TARGET, targetExplode).build();

        action.execute();

        var result = action.getCompetition().getActorPool().getRequest().getExplode();
        assertEquals(result, actorExplode);

        var result = action.getCompetition().getTargetPool().getRequest().getExplode();
        assertEquals(result, targetExplode);
    }

    public function testExplodeActor():Void
    {
        this.methodTestExplode(EnumExplode.DEFAULT, EnumExplode.ROTE_ACTION);
    }

    public function testExplodeTarget():Void
    {
        this.methodTestExplode(EnumExplode.ROTE_ACTION, EnumExplode.DEFAULT);
    }

    public function testExplodeBoth():Void
    {
        this.methodTestExplode(EnumExplode.ROTE_ACTION, EnumExplode.ROTE_ACTION);
    }
}
