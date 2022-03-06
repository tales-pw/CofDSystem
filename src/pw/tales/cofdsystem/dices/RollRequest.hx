package pw.tales.cofdsystem.dices;

import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose("RollRequest")
class RollRequest implements IRollRequest
{
    public var pool:IMathOperation<Int>;

    private var explode:EnumExplode = EnumExplode.DEFAULT;
    private var threshold:Int = 5;

    public function new(pool:IMathOperation<Int>)
    {
        this.pool = pool;
    }

    public function getPool():IMathOperation<Int>
    {
        return this.pool;
    }

    public function setThreshold(threshold:Int):Void
    {
        this.threshold = threshold;
    }

    public function getThreshold():Int
    {
        return this.threshold;
    }

    public function setExplode(permutation:EnumExplode):Void
    {
        this.explode = permutation;
    }

    public function getPoolSize():Int
    {
        return pool.calculate();
    }

    public function getExplode():EnumExplode
    {
        return this.explode;
    }
}
