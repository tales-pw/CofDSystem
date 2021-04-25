package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.character.traits.skill.Skills.*;
import pw.tales.cofdsystem.dices.pool.builder.PBMin;
import pw.tales.cofdsystem.dices.pool.builder.PBTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageExpression;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("DefenceAdvantage")
class DefenceAdvantage extends AdvantageExpression {
    public static final DN = "Защита";
    public static final TYPE:TraitType<DefenceAdvantage> = cast TraitType.createType(DN, create);

    private static final EXPR = new PBMin(new PBTrait(DEXTERITY.getDN()), new PBTrait(WITS.getDN())).plus(new PBTrait(ATHLETICS.getDN()));

    public function new(gameObject:GameObject) {
        super(gameObject, TYPE, EXPR);
    }

    public function loseDefence() {

    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<DefenceAdvantage>):DefenceAdvantage {
        return new DefenceAdvantage(gameObject);
    }
}
