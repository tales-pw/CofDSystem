package pw.tales.system.character.equipment;

import pw.tales.system.action_attack.builder.AttackBuilder;
import pw.tales.system.armor.prefabs.ArmorPrefab;
import pw.tales.system.character.traits.advantages.health.HealthAdvantage;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.character.traits.skill.Skills;
import pw.tales.system.character.traits.WornArmor;
import thx.Uuid;

@:nullSafety(Off)
class ArmorTestCase extends CofDSystemTestCase {
    private static final ARMOR = new ArmorPrefab(Uuid.create(), "", 2, 2, 0, 0, 0);

    override public function setup() {
        super.setup();
        c1.getTraitManager().getTrait(Attributes.STRENGTH).setValue(3);
        c1.getTraitManager().getTrait(Skills.BRAWL).setValue(2);

        c2.getTraitManager().getTrait(Attributes.DEXTERITY).setValue(1);
        c2.getTraitManager().getTrait(Attributes.WITS).setValue(1);
        c2.getTraitManager().getTrait(Skills.ATHLETICS).setValue(0);
        c2.getTraitManager().getTrait(WornArmor.TYPE).setArmor(ARMOR.createArmor(system));
    }

    public function testSimple() {
        var action = new AttackBuilder(c1, c2).build();
        system.act(action);

        var health:HealthAdvantage = cast(c2.getTraitManager().getTrait(HealthAdvantage.TYPE));

        assertEquals(2, health.getBashing());
        assertEquals(0, health.getLethal());
        assertEquals(0, health.getAggravated());
    }
}
