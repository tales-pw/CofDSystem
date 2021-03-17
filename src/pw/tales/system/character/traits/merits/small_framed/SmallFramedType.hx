package pw.tales.system.character.traits.merits.small_framed;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.character.traits.merits.MeritType;

class SmallFramedType extends MeritType {
    override public function isMultiInstanced():Bool {
        return false;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):SmallFramedMerit {
        return new SmallFramedMerit(this.getDN(), gameObject);
    }
}
