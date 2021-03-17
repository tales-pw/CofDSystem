package pw.tales.system.character.traits.tilts;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

class TiltType extends TraitType<Tilt> {
    override public function isMultiInstanced():Bool {
        return true;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):Tilt {
        return new Tilt(dn, gameObject, this);
    }
}
