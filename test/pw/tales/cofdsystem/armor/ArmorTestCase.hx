package pw.tales.cofdsystem.armor;

import pw.tales.cofdsystem.action_attack.builder.AttackBuilder;
import pw.tales.cofdsystem.armor.prefabs.ArmorPrefab;
import pw.tales.cofdsystem.character.traits.advantages.health.HealthAdvantage;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.character.traits.WornArmor;
import thx.Uuid;

@:nullSafety(Off)
class ArmorTestCase extends CofDSystemTestCase
{
    private static final ARMOR:ArmorPrefab = {
        dn: Uuid.create(),
        general: 2,
        ballistic: 2
    };

    override public function setup():Void
    {
        super.setup();
        c1.getTrait(Attributes.STRENGTH).setValue(3);
        c1.getTrait(Skills.BRAWL).setValue(2);

        c2.getTrait(Attributes.DEXTERITY).setValue(1);
        c2.getTrait(Attributes.WITS).setValue(1);
        c2.getTrait(Skills.ATHLETICS).setValue(0);
        c2.getTrait(WornArmor.TYPE).setArmor(ARMOR.createArmor(system));
    }

    public function testSimple():Void
    {
        var action = new AttackBuilder(c1, c2).build();
        action.execute();

        var health:HealthAdvantage = cast(c2.getTrait(HealthAdvantage.TYPE));

        assertEquals(2, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());
    }
}
