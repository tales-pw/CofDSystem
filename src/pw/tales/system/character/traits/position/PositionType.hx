package pw.tales.system.character.traits.position;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

class PositionType extends TraitType<PositionTrait> {
    override public function createWithDN(dn:String, gameObject:GameObject):PositionTrait {
        return new PositionTrait(gameObject);
    }
}
