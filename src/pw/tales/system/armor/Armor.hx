package pw.tales.system.armor;

import pw.tales.system.armor.traits.armor_rating.ArmorRating;
import pw.tales.system.armor.traits.DefenceModifer;
import pw.tales.system.armor.traits.SpeedModifer;
import pw.tales.system.armor.traits.StrengthReq;
import pw.tales.system.equipment.Equipment;
import pw.tales.system.game_object.GameObject;

class Armor extends Equipment implements IArmor {
    public function new(gameObject:GameObject) {
        super(gameObject);
    }

    public function getGeneral():Int {
        var armorRating = this.traitManager.getTrait(ArmorRating.TYPE);
        if (armorRating == null) return 0;
        return armorRating.getGeneral();
    }

    public function getBallistic():Int {
        var armorRating = this.traitManager.getTrait(ArmorRating.TYPE);
        if (armorRating == null) return 0;
        return armorRating.getBallistic();
    }

    public function getStrengthReq():Int {
        return this.getInt(StrengthReq.TYPE);
    }

    public function getDefenceMod():Int {
        return this.getInt(DefenceModifer.TYPE);
    }

    public function getSpeedMod():Int {
        return this.getInt(SpeedModifer.TYPE);
    }

    public function setHolder(gameObject:GameObject) {
        this.ensureEquipable().setHolder(gameObject);
    }

    public function unsetHolder() {
        this.ensureEquipable().unset();
    }
}
