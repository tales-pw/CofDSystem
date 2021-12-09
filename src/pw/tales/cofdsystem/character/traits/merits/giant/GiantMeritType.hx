package pw.tales.cofdsystem.character.traits.merits.giant;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.merits.MeritType;

@:expose("GiantMeritType")
class GiantMeritType extends MeritType
{
    override public function isMultiInstanced():Bool
    {
        return false;
    }

    override public dynamic function createWithDN(dn:String, gameObject:GameObject):Merit
    {
        return new GiantMerit(dn, gameObject, this);
    }
}
