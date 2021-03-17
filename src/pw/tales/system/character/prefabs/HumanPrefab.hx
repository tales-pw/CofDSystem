package pw.tales.system.character.prefabs;

import pw.tales.system.character.traits.advantages.DefenceAdvantage;
import pw.tales.system.character.traits.advantages.health.HealthAdvantage;
import pw.tales.system.character.traits.advantages.InitiativeAdvantage;
import pw.tales.system.character.traits.advantages.IntegrityAdvantage;
import pw.tales.system.character.traits.advantages.SizeAdvantage;
import pw.tales.system.character.traits.advantages.SpeedAdvantage;
import pw.tales.system.character.traits.advantages.WealthAdvantage;
import pw.tales.system.character.traits.advantages.willpower.WillpowerAdvantage;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.character.traits.HeldWeapon;
import pw.tales.system.character.traits.position.PositionTrait;
import pw.tales.system.character.traits.skill.Skills;
import pw.tales.system.character.traits.WornArmor;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.prefabs.Prefab;
import pw.tales.system.game_object.traits.text.TextTraitType;

class HumanPrefab extends Prefab {
    public static final INSTANCE = new HumanPrefab("human");

    public static final NAME = new TextTraitType("Name");
    public static final AGE = new TextTraitType("Age");
    public static final PLAYER = new TextTraitType("Player");

    public static final RACE = new TextTraitType("Race");
    public static final NATION = new TextTraitType("Nation");
    public static final LANGUAGE = new TextTraitType("Language");

    public static final VIRTUE = new TextTraitType("Добродетель");
    public static final VICE = new TextTraitType("Порок");
    public static final CONCEPT = new TextTraitType("Концепт");

    private override function setUpGameObject(gameObject:GameObject) {
        var traitManager = gameObject.getTraitManager();

        // Utility
        traitManager.addTrait(HeldWeapon.TYPE);
        traitManager.addTrait(WornArmor.TYPE);
        traitManager.addTrait(PositionTrait.TYPE);

        // Person
        traitManager.addTrait(NAME);
        traitManager.addTrait(AGE);
        traitManager.addTrait(PLAYER);

        traitManager.addTrait(RACE);
        traitManager.addTrait(NATION);
        traitManager.addTrait(LANGUAGE);

        traitManager.addTrait(VIRTUE);
        traitManager.addTrait(VICE);
        traitManager.addTrait(CONCEPT);

        // Attributes
        traitManager.addTrait(Attributes.INTELLIGENCE);
        traitManager.addTrait(Attributes.WITS);
        traitManager.addTrait(Attributes.RESOLVE);

        traitManager.addTrait(Attributes.STRENGTH);
        traitManager.addTrait(Attributes.DEXTERITY);
        traitManager.addTrait(Attributes.STAMINA);

        traitManager.addTrait(Attributes.PRESENCE);
        traitManager.addTrait(Attributes.MANIPULATION);
        traitManager.addTrait(Attributes.COMPOSURE);

        // Skills
        traitManager.addTrait(Skills.ACADEMICS);
        traitManager.addTrait(Skills.ENIGMAS);
        traitManager.addTrait(Skills.CRAFTS);
        traitManager.addTrait(Skills.INVESTIGATION);
        traitManager.addTrait(Skills.MEDICINE);
        traitManager.addTrait(Skills.OCCULT);
        traitManager.addTrait(Skills.POLITICS);
        traitManager.addTrait(Skills.SCIENCE);

        traitManager.addTrait(Skills.ATHLETICS);
        traitManager.addTrait(Skills.BRAWL);
        traitManager.addTrait(Skills.RIDE);
        traitManager.addTrait(Skills.SHOOTING);
        traitManager.addTrait(Skills.LARCENY);
        traitManager.addTrait(Skills.STEALTH);
        traitManager.addTrait(Skills.SURVIVAL);
        traitManager.addTrait(Skills.WEAPONRY);

        traitManager.addTrait(Skills.ANIMAL_KEN);
        traitManager.addTrait(Skills.EMPATHY);
        traitManager.addTrait(Skills.EXPRESSION);
        traitManager.addTrait(Skills.INTIMIDATION);
        traitManager.addTrait(Skills.PERSUASION);
        traitManager.addTrait(Skills.SOCIALIZE);
        traitManager.addTrait(Skills.STREETWISE);
        traitManager.addTrait(Skills.SUBTERFUGE);

        // Advantages
        traitManager.addTrait(DefenceAdvantage.TYPE);
        traitManager.addTrait(HealthAdvantage.TYPE);
        traitManager.addTrait(InitiativeAdvantage.TYPE);
        traitManager.addTrait(IntegrityAdvantage.TYPE);
        traitManager.addTrait(SizeAdvantage.TYPE);
        traitManager.addTrait(SpeedAdvantage.TYPE);
        traitManager.addTrait(WillpowerAdvantage.TYPE);
        traitManager.addTrait(WealthAdvantage.TYPE);

    }
}
