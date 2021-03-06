package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.armor.traits.SpeedModifer;
import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.dices.pool.builder.PBTrait;
import pw.tales.cofdsystem.dices.pool.builder.PBValue;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageExpression;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("SpeedAdvantage")
class SpeedAdvantage extends AdvantageExpression
{
    public static final DN = "Скорость";
    public static final TYPE:TraitType<SpeedModifer> = cast TraitType.createType(DN, create);

    private static final EXPR = new PBTrait(STRENGTH.getDN()).plus(new PBTrait(DEXTERITY.getDN())).plus(new PBValue(5));

    public function new(gameObject:GameObject)
    {
        super(gameObject, TYPE, EXPR);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<SpeedAdvantage>):SpeedAdvantage
    {
        return new SpeedAdvantage(gameObject);
    }
}
