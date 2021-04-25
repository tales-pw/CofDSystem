package pw.tales.cofdsystem.character.traits.tilts.leg_wrack;

import pw.tales.cofdsystem.game_object.GameObject;

class LegWrackTiltType extends TiltType {
    override public function createWithDN(dn:String, gameObject:GameObject):LegWrackTilt {
        return new LegWrackTilt(this.getDN(), gameObject, this);
    }
}