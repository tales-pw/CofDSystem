package pw.tales.system.damage;

@:keep
@:expose("Damage")
class Damage {
    private var bashing:Int;
    private var lethal:Int;
    private var aggravated:Int;

    public function new(bashing:Int, lethal:Int, aggravated:Int) {
        this.bashing = bashing;
        this.lethal = lethal;
        this.aggravated = aggravated;
    }

    public function getBashing():Int {
        return this.bashing;
    }

    public function getLethal():Int {
        return this.lethal;
    }

    public function getAggravated():Int {
        return this.aggravated;
    }

    public function enusreBashing() {
        if (bashing == 0 && lethal == 0 && aggravated == 0) bashing = 1;
    }

    public function applyGeneralArmor(generalArmor:Int) {
        if (aggravated != 0 && generalArmor != 0) {
            var tmp = Std.int(Math.max(aggravated - generalArmor, 0));
            generalArmor = Std.int(Math.max(generalArmor - aggravated, 0));
            aggravated = tmp;
        }

        if (lethal != 0 && generalArmor != 0) {
            var tmp = Std.int(Math.max(lethal - generalArmor, 0));
            generalArmor = Std.int(Math.max(generalArmor - lethal, 0));
            lethal = tmp;
        }

        if (bashing != 0 && generalArmor != 0) {
            bashing = Std.int(Math.max(bashing - generalArmor, 0));
        }
    }

    public function applyBallisticArmor(ballisticArmor:Int) {
        var bashingIncrement = Std.int(Math.min(ballisticArmor, lethal));
        lethal = Std.int(Math.max(lethal - ballisticArmor, 0));
        bashing = bashing + bashingIncrement;
    }

    public function toString():String {
        return 'Damage[bashing=$bashing, lethal=$lethal, aggravated=$aggravated]';
    }
}
