package pw.tales.cofdsystem.character.advancement.generation.trait_advancements;

import pw.tales.cofdsystem.character.traits.speciality.Specialities;
import pw.tales.cofdsystem.character.traits.speciality.Speciality;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

typedef SpecialityType = TraitType<Speciality>;

class GenSpecialityAdvancement extends GenAdvancementItem<Speciality, SpecialityType>
{
    public static final SPECIALITY_GENERATION_LIMIT = 3;

    public function new(gameObject:GameObject)
    {
        super(Speciality, SpecialityType, gameObject);
    }

    public override function canTraitBeAdded(specialityType:SpecialityType):Bool
    {
        var amount:Int = Specialities.collect(gameObject).length;
        return amount + 1 <= SPECIALITY_GENERATION_LIMIT;
    }

    public override function canTraitBeUpdated(speciality:Speciality, newValue:Int):Bool
    {
        return true;
    }
}
