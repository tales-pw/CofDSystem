package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.character.traits.skill.Skills.*;
import pw.tales.cofdsystem.pool.builder.PBMin;
import pw.tales.cofdsystem.pool.builder.PBTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageExpression;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("DefenceAdvantage")
class DefenceAdvantage extends AdvantageExpression
{
    public static final DN = "Защита";
    public static final TYPE = TraitType.createType(DN, DefenceAdvantage.new);

    private static final EXPR = new PBMin(
        new PBTrait(DEXTERITY),
        new PBTrait(WITS)
    ).plus(new PBTrait(ATHLETICS));

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
