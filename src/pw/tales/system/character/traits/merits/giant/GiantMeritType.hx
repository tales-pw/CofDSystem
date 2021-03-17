package pw.tales.system.character.traits.merits.giant;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.character.traits.merits.MeritType;

class GiantMeritType extends MeritType {
    override public function isMultiInstanced():Bool {
        return false;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):GiantMerit {
        return new GiantMerit(this.getDN(), gameObject);
    }
}
