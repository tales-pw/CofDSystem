package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.common.traits.advantages.IAdvantage;
import pw.tales.cofdsystem.game_object.traits.expression.ExpressionTrait;
import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.character.traits.skill.Skills.*;
import pw.tales.cofdsystem.dices.pool.builder.PBMin;
import pw.tales.cofdsystem.dices.pool.builder.PBTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("DefenceAdvantage")
class DefenceAdvantage extends ExpressionTrait implements IAdvantage
{
    public static final DN = "Защита";
    public static final TYPE = TraitType.createType(DN, DefenceAdvantage.new);

    private static final EXPR = new PBMin(
        new PBTrait(DEXTERITY.getDN()),
        new PBTrait(WITS.getDN())
    ).plus(new PBTrait(ATHLETICS.getDN()));

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, EXPR);
    }

    public function loseDefence():Void {}
}
