package pw.tales.cofdsystem.character.traits.advantages.willpower;

import pw.tales.cofdsystem.character.traits.advantages.willpower.exceptions.NoWillpowerException;
import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.dices.pool.builder.PBTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageExpression;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("WillpowerAdvantage")
class WillpowerAdvantage extends AdvantageExpression {
    public static final DN = "Сила_воли";
    public static final TYPE:TraitType<WillpowerAdvantage> = cast TraitType.createType(DN, create);

    private static final EXPR = new PBTrait(RESOLVE.getDN()).plus(new PBTrait(COMPOSURE.getDN()));

    @Serialize("points")
    private var points:Null<Int> = null;

    public function new(gameObject:GameObject) {
        super(gameObject, TYPE, EXPR);
    }

    public function canUse():Bool {
        return this.getPoints() > 0;
    }

    public function getPoints():Int {
        if (this.points != null) return this.points;
        return this.getValue();
    }

    public function burnWillpower() {
        var newPoints = this.getPoints() - 1;

        if (!this.canUse()) {
            throw new NoWillpowerException(this);
        }

        this.points = newPoints;
        this.notifyUpdated();
    }

    public static function create(
        dn:String,
        gameObject:GameObject,
        t:TraitType<WillpowerAdvantage>
    ):WillpowerAdvantage {
        return new WillpowerAdvantage(gameObject);
    }
}
