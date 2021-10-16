package pw.tales.cofdsystem.character.traits;

import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("Experience")
class Experience extends Trait
{
    public static final DN = "Опыт";
    public static final TYPE = TraitType.createType(DN, Experience.new);

    public static final BEAT_AMOUNT = 5;

    @Serialize("beats")
    private var beats:Int = 0;

    @Serialize("spent")
    private var spent:Int = 0;

    public function getExperience():Int
    {
        return Std.int(this.beats / BEAT_AMOUNT) - this.spent;
    }

    public function getBeats():Int
    {
        return this.beats % BEAT_AMOUNT;
    }

    public function grantBeat():Void
    {
        this.beats += 1;
        this.notifyUpdated();
    }

    public function isEnough(amount:Int):Bool
    {
        return this.getExperience() < amount;
    }

    public function spend(amount:Int, restriction = true):Void
    {
        if (restriction && this.isEnough(amount))
        {
            throw "Not enough experience!";
        }

        this.spent += amount;
        this.notifyUpdated();
    }
}
