package pw.tales.system.character.advancement.generation;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

class GenAdvancementType extends TraitType<GenAdvancement> {
    override public function createWithDN(dn:String, gameObject:GameObject):GenAdvancement {
        return new GenAdvancement(gameObject);
    }
}