package pw.tales.system.character.traits.tilts.stunned;

import pw.tales.system.game_object.GameObject;

class StunnedTiltType extends TiltType {
    override public function createWithDN(dn:String, gameObject:GameObject):StunnedTilt {
        return new StunnedTilt(this.getDN(), gameObject, this);
    }
}
