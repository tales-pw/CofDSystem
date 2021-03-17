package pw.tales.system.character.traits.advantages;

import pw.tales.system.character.traits.attribute.Attributes.*;
import pw.tales.system.character.traits.skill.Skills.*;
import pw.tales.system.dices.pool.builder.PBMin;
import pw.tales.system.dices.pool.builder.PBTrait;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.advantages.AdvantageExpression;
import pw.tales.system.game_object.traits.TraitType;

@:keep
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
