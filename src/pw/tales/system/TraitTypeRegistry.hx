package pw.tales.system;

import pw.tales.system.armor.traits.armor_rating.ArmorRating;
import pw.tales.system.armor.traits.DefenceModifer;
import pw.tales.system.armor.traits.SpeedModifer;
import pw.tales.system.armor.traits.StrengthReq;
import pw.tales.system.character.advancement.generation.GenAdvancement;
import pw.tales.system.character.prefabs.HumanPrefab;
import pw.tales.system.character.prefabs.PlayerPrefab;
import pw.tales.system.character.traits.advantages.DefenceAdvantage;
import pw.tales.system.character.traits.advantages.health.HealthAdvantage;
import pw.tales.system.character.traits.advantages.InitiativeAdvantage;
import pw.tales.system.character.traits.advantages.IntegrityAdvantage;
import pw.tales.system.character.traits.advantages.SizeAdvantage;
import pw.tales.system.character.traits.advantages.SpeedAdvantage;
import pw.tales.system.character.traits.advantages.WealthAdvantage;
import pw.tales.system.character.traits.advantages.willpower.WillpowerAdvantage;
import pw.tales.system.character.traits.aspiration.Aspirations;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.character.traits.Experience;
import pw.tales.system.character.traits.HeldWeapon;
import pw.tales.system.character.traits.merits.ambidextrous.AmbidextrousMerit;
import pw.tales.system.character.traits.merits.fleet_of_foot.FleetOfFootMerit;
import pw.tales.system.character.traits.merits.giant.GiantMerit;
import pw.tales.system.character.traits.merits.Merit;
import pw.tales.system.character.traits.merits.small_framed.SmallFramedMerit;
import pw.tales.system.character.traits.position.PositionTrait;
import pw.tales.system.character.traits.skill.Skills;
import pw.tales.system.character.traits.speciality.Speciality;
import pw.tales.system.character.traits.tilts.arm_wrack.ArmWrackTilt;
import pw.tales.system.character.traits.tilts.blinded.BlindedTilt;
import pw.tales.system.character.traits.tilts.leg_wrack.LegWrackTilt;
import pw.tales.system.character.traits.tilts.stunned.StunnedTilt;
import pw.tales.system.character.traits.WornArmor;
import pw.tales.system.equipment.traits.EquipmentBonus;
import pw.tales.system.equipment.traits.Equippable;
import pw.tales.system.equipment.traits.HoldingHand;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.registry.Registry;
import pw.tales.system.weapon.traits.DamageMod;
import pw.tales.system.weapon.traits.InitiativeMod;
import pw.tales.system.weapon.traits.LethalDamage;
import pw.tales.system.weapon.traits.weapon_tags.AccurateTag;
import pw.tales.system.weapon.traits.weapon_tags.BrawlTag;
import pw.tales.system.weapon.traits.weapon_tags.ConcealedTag;
import pw.tales.system.weapon.traits.weapon_tags.EightAgainTag;
import pw.tales.system.weapon.traits.weapon_tags.FinesseTag;
import pw.tales.system.weapon.traits.weapon_tags.GrappleTag;
import pw.tales.system.weapon.traits.weapon_tags.GuardTag;
import pw.tales.system.weapon.traits.weapon_tags.MercyTag;
import pw.tales.system.weapon.traits.weapon_tags.NineAgainTag;
import pw.tales.system.weapon.traits.weapon_tags.piercing.PiercingTagType;
import pw.tales.system.weapon.traits.weapon_tags.ReachTag;
import pw.tales.system.weapon.traits.weapon_tags.StunTag;
import pw.tales.system.weapon.traits.weapon_tags.TwoHandedTag;
import pw.tales.system.weapon_melee.traits.MeleeWeapon;
import pw.tales.system.weapon_ranged.traits.RangedWeapon;

class TraitTypeRegistry extends Registry<TraitType<Dynamic>> {
    public function new() {
        super(true);

        var customMeritType = Merit.CUSTOM_MERIT_TYPE;
        customMeritType.setName("Пользовательское Достоинство");
        this.register(customMeritType);

        // TODO: Use annotation
        // TODO: Use macros to get all classes compile-time.

        // Characters
        this.registerFromClass(HumanPrefab);
        this.registerFromClass(PlayerPrefab);
        this.registerFromClass(Aspirations);
        this.registerFromClass(Attributes);
        this.registerFromClass(WornArmor);
        this.registerFromClass(HeldWeapon);
        this.registerFromClass(Experience);
        this.registerFromClass(PositionTrait);
        this.registerFromClass(Skills);
        this.registerFromClass(Speciality);
        this.registerFromClass(GenAdvancement);

        // Advantages
        this.registerFromClass(DefenceAdvantage);
        this.registerFromClass(HealthAdvantage);
        this.registerFromClass(InitiativeAdvantage);
        this.registerFromClass(IntegrityAdvantage);
        this.registerFromClass(SizeAdvantage);
        this.registerFromClass(SpeedAdvantage);
        this.registerFromClass(WealthAdvantage);
        this.registerFromClass(WillpowerAdvantage);

        // Merits
        this.registerFromClass(AmbidextrousMerit);
        this.registerFromClass(FleetOfFootMerit);
        this.registerFromClass(GiantMerit);
        this.registerFromClass(SmallFramedMerit);

        // Tilts
        this.registerFromClass(ArmWrackTilt);
        this.registerFromClass(BlindedTilt);
        this.registerFromClass(LegWrackTilt);
        this.registerFromClass(StunnedTilt);

        // Equipment Traits
        this.registerFromClass(Equippable);
        this.registerFromClass(HoldingHand);
        this.registerFromClass(EquipmentBonus);

        // Weapon Traits
        this.registerFromClass(DamageMod);
        this.registerFromClass(InitiativeMod);
        this.registerFromClass(MeleeWeapon);
        this.registerFromClass(RangedWeapon);
        this.registerFromClass(LethalDamage);

        // Weapon Tags
        this.registerFromClass(AccurateTag);
        this.registerFromClass(BrawlTag);
        this.registerFromClass(ConcealedTag);
        this.registerFromClass(GuardTag);
        this.registerFromClass(EightAgainTag);
        this.registerFromClass(FinesseTag);
        this.registerFromClass(GrappleTag);
        this.registerFromClass(NineAgainTag);

        this.register(new PiercingTagType(1));
        this.register(new PiercingTagType(2));
        this.register(new PiercingTagType(3));
        this.register(new PiercingTagType(4));
        this.register(new PiercingTagType(5));

        this.registerFromClass(ReachTag);
        this.registerFromClass(StunTag);
        this.registerFromClass(TwoHandedTag);
        this.registerFromClass(MercyTag);

        // Armor stats
        this.registerFromClass(ArmorRating);
        this.registerFromClass(DefenceModifer);
        this.registerFromClass(SpeedModifer);
        this.registerFromClass(StrengthReq);
    }

    private function registerFromClass(clazz:Class<Dynamic>) {
        for (fieldName in Type.getClassFields(clazz)) {
            var field = Reflect.getProperty(clazz, fieldName);
            if (Std.isOfType(field, TraitType)) {
                this.register(cast(field));
            }
        }
    }
}
