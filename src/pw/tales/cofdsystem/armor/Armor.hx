package pw.tales.cofdsystem.armor;

import pw.tales.cofdsystem.armor.traits.armor_rating.ArmorRating;
import pw.tales.cofdsystem.armor.traits.DefenceModifer;
import pw.tales.cofdsystem.armor.traits.SpeedModifer;
import pw.tales.cofdsystem.armor.traits.StrengthReq;
import pw.tales.cofdsystem.equipment.Equipment;
import pw.tales.cofdsystem.game_object.GameObject;

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

    public override function setHolder(gameObject:GameObject) {
        super.setHolder(gameObject);
    }

    public override function unsetHolder() {
        super.ensureEquipable().unset();
    }
}
