package pw.tales.system.character.traits.advantages;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.advantages.Advantage;
import pw.tales.system.game_object.traits.TraitType;

@:keep
@:expose("IntegrityAdvantage")
class IntegrityAdvantage extends Advantage {
    public static final DN = "Целостность";
    public static final TYPE:TraitType<IntegrityAdvantage> = cast TraitType.createType(DN, create);

    @Serialize("points")
    private var points:Int = 7;

    public function new(gameObject:GameObject) {
        super(gameObject, TYPE);
    }

    override public function getValue():Int {
        return this.points;
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<IntegrityAdvantage>):IntegrityAdvantage {
        return new IntegrityAdvantage(gameObject);
    }
}
