package pw.tales.cofdsystem.character.advancement.generation.trait_advancements;

import pw.tales.cofdsystem.character.traits.advantages.WealthAdvantage;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

typedef WealthAdvantageType = TraitType<WealthAdvantage>;

@:expose("GenWealthAdvancement")
class GenWealthAdvancement extends GenMeritGroupAdvancement<WealthAdvantage, WealthAdvantageType>
{
    public function new(gameObject:GameObject)
    {
        super(
            WealthAdvantage,
            WealthAdvantageType,
            gameObject
        );
    }

    public override function canTraitBeAdded(wealthAdvantageType:WealthAdvantageType):Bool
    {
        return true;
    }

    public override function canTraitBeUpdated(wealth:WealthAdvantage, newValue:Int):Bool
    {
        var meritTotal = this.calcualteMeritTotal();

        return meritTotal - wealth.getValue() + newValue <= GenMeritGroupAdvancement.MERIT_GENERATION_LIMIT;
    }
}
