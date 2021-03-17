package pw.tales.system.character.traits.tilts.blinded;

import pw.tales.system.game_object.GameObject;

class BlindedTiltType extends TiltType {
    override public function createWithDN(dn:String, gameObject:GameObject):BlindedTilt {
        return new BlindedTilt(this.getDN(), gameObject, this);
    }
}
