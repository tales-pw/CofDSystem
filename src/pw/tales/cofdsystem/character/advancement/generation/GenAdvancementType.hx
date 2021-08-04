package pw.tales.cofdsystem.character.advancement.generation;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class GenAdvancementType extends TraitType<GenAdvancement>
{
    override public function createWithDN(dn:String, gameObject:GameObject):GenAdvancement
    {
        return new GenAdvancement(gameObject);
    }
}
