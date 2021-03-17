package pw.tales.system.character.advancement;

import pw.tales.system.character.advancement.generation.GenAdvancement;
import pw.tales.system.character.traits.advantages.WealthAdvantage;
import pw.tales.system.character.traits.attribute.Attribute;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.character.traits.merits.Merit;
import pw.tales.system.character.traits.merits.MeritType;
import pw.tales.system.character.traits.skill.Skill;
import pw.tales.system.character.traits.skill.Skills;
import pw.tales.system.character.traits.speciality.Speciality;

@:nullSafety(Off)
class GenAdvancementTestCase extends CofDSystemTestCase {
    public static final MERIT_TYPE = new MeritType("test");

    public override function setup() {
        super.setup();
        c1.getTraitManager().addTrait(GenAdvancement.TYPE);
        c2.getTraitManager().addTrait(GenAdvancement.TYPE);

        system.traits.register(MERIT_TYPE);
    }

    public function testUpdateWealth() {
        var manager = c1.getTraitManager();

        var merit_1:Merit = cast manager.addTrait(MERIT_TYPE);
        merit_1.setValue(5);

        var wealth:WealthAdvantage = cast(manager.getTrait(WealthAdvantage.TYPE));
        assertTrue(wealth.canUpdate(5));
        wealth.setValue(5);
        assertFalse(wealth.canUpdate(6));
    }

    public function testAddAndUpdateMerit() {
        var m = c1.getTraitManager();

        var merit_1:Merit = cast m.addTrait(MERIT_TYPE);
        merit_1.setValue(5);

        var merit_2:Merit = cast m.addTrait(MERIT_TYPE);
        merit_2.setValue(3);

        var merit_3:Merit = cast m.addTrait(MERIT_TYPE);
        assertEquals(false, merit_3.canUpdate(3));

        merit_3.setValue(2);
        assertEquals(2, merit_3.getValue());

        assertFalse(MERIT_TYPE.canAdd(c1));
    }

    public function testAddSpeciality() {
        var m = c1.getTraitManager();

        assertTrue(m.addTrait(Speciality.TYPE) != null);
        assertTrue(m.addTrait(Speciality.TYPE) != null);
        assertTrue(m.addTrait(Speciality.TYPE) != null);
        assertFalse(Speciality.TYPE.canAdd(c1));
    }

    public function testUpdateAttribute() {
        var m = c1.getTraitManager();

        // Mental
        var intelligence:Attribute = cast m.getTrait(Attributes.INTELLIGENCE);
        assertTrue(intelligence.canUpdate(1));
        assertFalse(intelligence.canUpdate(0));
        assertTrue(intelligence.canUpdate(5));
        intelligence.setValue(5);

        var wits:Attribute = cast m.getTrait(Attributes.WITS);
        assertTrue(wits.canUpdate(2));
        assertFalse(wits.canUpdate(3));
        wits.setValue(2);

        // Physical
        var strength:Attribute = cast m.getTrait(Attributes.STRENGTH);
        assertTrue(strength.canUpdate(5));
        strength.setValue(5);

        var dexterity:Attribute = cast m.getTrait(Attributes.DEXTERITY);
        assertFalse(dexterity.canUpdate(2));

        // Physical
        var presence:Attribute = cast m.getTrait(Attributes.PRESENCE);
        assertTrue(presence.canUpdate(4));
        assertFalse(presence.canUpdate(5));
        presence.setValue(4);

        var manipulation:Attribute = cast m.getTrait(Attributes.MANIPULATION);
        assertFalse(manipulation.canUpdate(2));
    }

    public function testUpdateAttributeWhenFull() {
        var m = c1.getTraitManager();

        // Set up full group
        var intelligence:Attribute = cast m.getTrait(Attributes.INTELLIGENCE);
        assertTrue(intelligence.canUpdate(1));
        assertFalse(intelligence.canUpdate(0));
        assertTrue(intelligence.canUpdate(5));
        intelligence.setValue(5);

        var wits:Attribute = cast m.getTrait(Attributes.WITS);
        assertTrue(wits.canUpdate(2));
        assertFalse(wits.canUpdate(3));
        wits.setValue(2);

        assertTrue(intelligence.canUpdate(4));
    }

    public function testUpdateSkills() {
        var m = c1.getTraitManager();

        // Mental
        var academics:Skill = cast m.getTrait(Skills.ACADEMICS);
        assertTrue(academics.canUpdate(0));
        assertTrue(academics.canUpdate(5));
        academics.setValue(5);

        var science:Skill = cast m.getTrait(Skills.SCIENCE);
        assertTrue(science.canUpdate(5));
        science.setValue(5);

        var occult:Skill = cast m.getTrait(Skills.OCCULT);
        assertTrue(occult.canUpdate(1));
        assertFalse(occult.canUpdate(2));
        occult.setValue(1);

        // Physical
        var athletics:Skill = cast m.getTrait(Skills.ATHLETICS);
        assertTrue(athletics.canUpdate(5));
        athletics.setValue(5);

        var brawl:Skill = cast m.getTrait(Skills.BRAWL);
        assertTrue(brawl.canUpdate(2));
        assertFalse(brawl.canUpdate(3));
        brawl.setValue(2);

        // Social
        var animal_ken:Skill = cast m.getTrait(Skills.ANIMAL_KEN);
        assertTrue(animal_ken.canUpdate(4));
        assertFalse(animal_ken.canUpdate(5));
        athletics.setValue(4);
    }

    public function testUpdateSkillWhenFull() {
        var m = c1.getTraitManager();

        // Set up full group
        var academics:Skill = cast(m.getTrait(Skills.ACADEMICS));
        academics.setValue(5);

        var science:Skill = cast(m.getTrait(Skills.SCIENCE));
        science.setValue(5);

        var occult:Skill = cast(m.getTrait(Skills.OCCULT));
        occult.setValue(1);

        assertTrue(science.canUpdate(4));
    }
}