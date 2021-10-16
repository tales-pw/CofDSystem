package pw.tales.cofdsystem.character.traits.merits.small_framed;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.merits.MeritType;

class SmallFramedType extends MeritType
{
    override public function isMultiInstanced():Bool
    {
        return false;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):SmallFramedMerit
    {
        return new SmallFramedMerit(dn, gameObject);
    }
}
