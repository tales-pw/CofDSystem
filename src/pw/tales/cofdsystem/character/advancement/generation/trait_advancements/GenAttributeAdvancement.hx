package pw.tales.cofdsystem.character.advancement.generation.trait_advancements;

import pw.tales.cofdsystem.character.traits.attribute.Attribute;
import pw.tales.cofdsystem.character.traits.attribute.AttributeType;
import pw.tales.cofdsystem.game_object.GameObject;

class GenAttributeAdvancement extends GenGroupAdvancement<Attribute, AttributeType>
{
    private static final FREEBUYS:Array<Int> = [5, 4, 3];

    public function new(gameObject:GameObject)
    {
        super(Attribute, AttributeType, gameObject, FREEBUYS);
    }

    public override function getMinValue():Int
    {
        return Attribute.STARTING_VALUE;
    }

    public override function getGroup(traitType:AttributeType):String
    {
        return traitType.getGroup().getName();
    }
}
