package pw.tales.cofdsystem.character.traits.merits.giant;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.merits.MeritType;

class GiantMeritType extends MeritType
{
    override public function isMultiInstanced():Bool
    {
        return false;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):GiantMerit
    {
        return new GiantMerit(dn, gameObject, this);
    }
}
