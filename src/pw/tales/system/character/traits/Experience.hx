package pw.tales.system.character.traits;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;

@:keep
@:expose("Experience")
class Experience extends Trait {
    public static final DN = "Опыт";
    public static final TYPE:TraitType<Experience> = cast TraitType.createType(DN, create);

    public static final BEAT_AMOUNT = 5;

    @Serialize("beats")
    private var beats:Int = 0;

    @Serialize("spent")
    private var spent:Int = 0;

    public function new(gameObject:GameObject) {
        super(TYPE.getDN(), gameObject, TYPE);
    }

    public function getExperience() {
        return Std.int(this.beats / BEAT_AMOUNT) - this.spent;
    }

    public function getBeats() {
        return this.beats % BEAT_AMOUNT;
    }

    public function grantBeat() {
        this.beats += 1;
        this.notifyUpdated();
    }

    public function isEnough(amount:Int) {
        return this.getExperience() < amount;
    }

    public function spend(amount:Int, restriction = true) {
        if (restriction && this.isEnough(amount)) {
            throw "Not enough experience!";
        }

        this.spent += amount;
        this.notifyUpdated();
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<Experience>):Experience {
        return new Experience(gameObject);
    }
}
