package pw.tales.cofdsystem.character.traits.position;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@:expose("PositionType")
class PositionType extends TraitType<PositionTrait>
{
    override public dynamic function createWithDN(dn:String, gameObject:GameObject):PositionTrait
    {
        return new PositionTrait(gameObject);
    }
}
