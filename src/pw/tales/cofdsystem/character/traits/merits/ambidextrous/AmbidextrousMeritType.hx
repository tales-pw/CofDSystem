package pw.tales.cofdsystem.character.traits.merits.ambidextrous;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.merits.MeritType;

class AmbidextrousMeritType extends MeritType {
    override public function isMultiInstanced():Bool {
        return false;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):AmbidextrousMerit {
        return new AmbidextrousMerit(this.getDN(), gameObject);
    }
}
