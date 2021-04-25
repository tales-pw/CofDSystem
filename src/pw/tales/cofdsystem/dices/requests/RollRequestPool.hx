package pw.tales.cofdsystem.dices.requests;

class RollRequestPool extends ABSRollRequest {
    private var poolSize:Int;

    public function new(poolSize:Int) {
        super();
        this.poolSize = poolSize;
    }

    override public function getPoolSize():Int {
        return this.poolSize;
    }
}
