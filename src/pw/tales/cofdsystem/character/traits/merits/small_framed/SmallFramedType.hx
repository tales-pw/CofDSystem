package pw.tales.cofdsystem.character.traits.merits.small_framed;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.merits.MeritType;

@:expose("SmallFramedType")
class SmallFramedType extends MeritType
{
    override public function isMultiInstanced():Bool
    {
        return false;
    }

    override public dynamic function createWithDN(dn:String, gameObject:GameObject):Merit
    {
        return new SmallFramedMerit(dn, gameObject, this);
    }
}
