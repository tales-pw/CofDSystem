package pw.tales.cofdsystem.character.prefabs;

import pw.tales.cofdsystem.common.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.health.HealthAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.InitiativeAdvantage;
import pw.tales.cofdsystem.character.traits.advantages.IntegrityAdvantage;
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

@:structInit @:expose("HumanPrefab")
class HumanPrefab extends Prefab
{
    public static final INSTANCE:HumanPrefab = {
        dn: "human"
    };

    private static final TRAITS:Array<TraitType<Dynamic>> = [
        // Utility
        HeldWeapon.TYPE,
        WornArmor.TYPE,
        PositionTrait.TYPE,
        // Person
        Character.NAME,
        Character.AGE,
        Character.PLAYER,
        Character.RACE,
        Character.NATION,
        Character.LANGUAGE,
        Character.VIRTUE,
        Character.VICE,
        Character.CONCEPT,
        // Attributes
        // Mental
        Attributes.INTELLIGENCE,
        Attributes.WITS,
        Attributes.RESOLVE,
        // Physical
        Attributes.STRENGTH,
        Attributes.DEXTERITY,
        Attributes.STAMINA,
        // Social
        Attributes.PRESENCE,
        Attributes.MANIPULATION,
        Attributes.COMPOSURE,
        // Skills
        // Mental
        Skills.ACADEMICS,
        Skills.ENIGMAS,
        Skills.CRAFTS,
        Skills.INVESTIGATION,
        Skills.MEDICINE,
        Skills.OCCULT,
        Skills.POLITICS,
        Skills.SCIENCE,
        // Physical
        Skills.ATHLETICS,
        Skills.BRAWL,
        Skills.RIDE,
        Skills.SHOOTING,
        Skills.LARCENY,
        Skills.STEALTH,
        Skills.SURVIVAL,
        Skills.WEAPONRY,
        // Social
        Skills.ANIMAL_KEN,
        Skills.EMPATHY,
        Skills.EXPRESSION,
        Skills.INTIMIDATION,
        Skills.PERSUASION,
        Skills.SOCIALIZE,
        Skills.STREETWISE,
        Skills.SUBTERFUGE,
        // Advantages
        DefenceAdvantage.TYPE,
        HealthAdvantage.TYPE,
        InitiativeAdvantage.TYPE,
        IntegrityAdvantage.TYPE,
        SizeAdvantage.TYPE,
        SpeedAdvantage.TYPE,
        WillpowerAdvantage.TYPE,
        WealthAdvantage.TYPE,
    ];

    private override function setUpGameObject(gameObject:GameObject):Void
    {
        var traitManager = gameObject.getTraitManager();

        for (record in TRAITS)
        {
            traitManager.addTrait(record);
        }
    }
}
