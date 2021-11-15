package pw.tales.cofdsystem.character.advancement.generation.trait_advancements;

import pw.tales.cofdsystem.character.traits.merits.Merit;
import pw.tales.cofdsystem.character.traits.merits.MeritType;
import pw.tales.cofdsystem.game_object.GameObject;

@:expose("GenMeritAdvancement")
class GenMeritAdvancement extends GenMeritGroupAdvancement<Merit, MeritType>
{
    public function new(gameObject:GameObject)
    {
        super(Merit, MeritType, gameObject);
    }

    public override function canTraitBeAdded(meritType:MeritType):Bool
    {
        var newValue = meritType.getLowestValue();
        var meritTotal = this.calcualteMeritTotal();

        return meritTotal + newValue <= GenMeritGroupAdvancement.MERIT_GENERATION_LIMIT;
    }

    public override function canTraitBeUpdated(merit:Merit, newValue:Int):Bool
    {
        var meritTotal = this.calcualteMeritTotal();

        return meritTotal - merit.getValue() + newValue <= GenMeritGroupAdvancement.MERIT_GENERATION_LIMIT;
    }
}
