package pw.tales.cofdsystem.character.traits.tilts.arm_wrack;

import pw.tales.cofdsystem.game_object.GameObject;

class ArmWrackTiltType extends TiltType
{
    override public function createWithDN(dn:String, gameObject:GameObject):ArmWrackTilt
    {
        return new ArmWrackTilt(this.getDN(), gameObject, this);
    }
}
