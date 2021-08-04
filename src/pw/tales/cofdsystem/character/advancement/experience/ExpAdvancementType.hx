package pw.tales.cofdsystem.character.advancement.experience;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

class ExpAdvancementType extends TraitType<ExpAdvancement>
{
    override public function createWithDN(dn:String, gameObject:GameObject):ExpAdvancement
    {
        return new ExpAdvancement(gameObject);
    }
}
