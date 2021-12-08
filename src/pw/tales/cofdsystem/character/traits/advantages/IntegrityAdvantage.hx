package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.game_object.traits.advantages.Advantage;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("IntegrityAdvantage")
class IntegrityAdvantage extends Advantage
{
    public static final DN = "Целостность";
    public static final TYPE = TraitType.createType(DN, IntegrityAdvantage.new);

    @Serialize("points")
    private var points:Int = 7;

    override public function getValue():Int
    {
        return this.points;
    }
}
