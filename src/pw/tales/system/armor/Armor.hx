package pw.tales.system.armor;

import pw.tales.system.armor.traits.armor_rating.ArmorRating;
import pw.tales.system.armor.traits.DefenceModifer;
import pw.tales.system.armor.traits.SpeedModifer;
import pw.tales.system.armor.traits.StrengthReq;
import pw.tales.system.equipment.traits.Equippable;
import pw.tales.system.game_object.GameObject;

class Armor implements IArmor {
    private final gameObject:GameObject;
    private final armorRating:ArmorRating;
    private final defenceModifier:DefenceModifer;
    private final speedModifier:SpeedModifer;
    private final strengthRequirements:StrengthReq;
    private final equippable:Equippable;

    public function new(gameObject:GameObject) {
        this.gameObject = gameObject;

        var manager = this.gameObject.getTraitManager();
        this.armorRating = cast manager.getTrait(ArmorRating.TYPE);
        this.defenceModifier = cast manager.getTrait(DefenceModifer.TYPE);
        this.speedModifier = cast manager.getTrait(SpeedModifer.TYPE);
        this.strengthRequirements = cast manager.getTrait(StrengthReq.TYPE);
        this.equippable = cast manager.getTrait(Equippable.TYPE);
    }

    public function getGeneral():Int {
        return this.armorRating.getGeneral();
    }

    public function getBallistic():Int {
        return this.armorRating.getBallistic();
    }

    public function getStrengthReq():Int {
        return this.strengthRequirements.getValue();
    }

    public function getDefenceMod():Int {
        return this.defenceModifier.getValue();
    }

    public function getSpeedMod():Int {
        return speedModifier.getValue();
    }

    public function setHolder(gameObject: GameObject) {
        this.equippable.setHolder(gameObject);
    }

    public function unsetHolder() {
        this.equippable.unset();
    }
}
