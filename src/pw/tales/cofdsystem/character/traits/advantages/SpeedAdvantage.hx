package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageExpression;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("SpeedAdvantage")
class SpeedAdvantage extends AdvantageExpression
{
    public static final DN = "Скорость";
    public static final TYPE = cast TraitType.createType(DN, SpeedAdvantage.new);

    private static final EXPR = STRENGTH.plus(DEXTERITY).plus(5);

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, EXPR);
    }
}
