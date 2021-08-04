package pw.tales.cofdsystem.character.traits.position;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class PositionType extends TraitType<PositionTrait>
{
    override public function createWithDN(dn:String, gameObject:GameObject):PositionTrait
    {
        return new PositionTrait(gameObject);
    }
}
