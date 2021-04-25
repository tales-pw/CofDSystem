package pw.tales.cofdsystem.character.prefabs;

import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.health.HealthAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.InitiativeAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.IntegrityAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.SpeedAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.WealthAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.willpower.WillpowerAdvantage;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.character.traits.position.PositionTrait;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.character.traits.WornArmor;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.prefabs.Prefab;

class HumanPrefab extends Prefab {
    public static final INSTANCE = new HumanPrefab("human");

    private override function setUpGameObject(gameObject:GameObject) {
        var traitManager = gameObject.getTraitManager();

        // Utility
        traitManager.addTrait(HeldWeapon.TYPE);
        traitManager.addTrait(WornArmor.TYPE);
        traitManager.addTrait(PositionTrait.TYPE);

        // Person
        traitManager.addTrait(Character.NAME);
        traitManager.addTrait(Character.AGE);
        traitManager.addTrait(Character.PLAYER);

        traitManager.addTrait(Character.RACE);
        traitManager.addTrait(Character.NATION);
        traitManager.addTrait(Character.LANGUAGE);

        traitManager.addTrait(Character.VIRTUE);
        traitManager.addTrait(Character.VICE);
        traitManager.addTrait(Character.CONCEPT);

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
