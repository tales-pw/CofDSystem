package pw.tales.system.character.traits.merits.ambidextrous;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.character.traits.merits.MeritType;

class AmbidextrousMeritType extends MeritType {
    override public function isMultiInstanced():Bool {
        return false;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):AmbidextrousMerit {
        return new AmbidextrousMerit(this.getDN(), gameObject);
    }
}
