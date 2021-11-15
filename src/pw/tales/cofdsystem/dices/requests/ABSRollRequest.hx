package pw.tales.cofdsystem.dices.requests;

import thx.error.NotImplemented;

@:expose("ABSRollRequest")
class ABSRollRequest implements IRollRequest
{
    private var explode:EnumExplode = EnumExplode.DEFAULT;
    private var threshold:Int = 5;

    private function new() {}

    public function setThreshold(threshold:Int)
    {
        this.threshold = threshold;
    }

    public function getThreshold():Int
    {
        return this.threshold;
    }

    public function setExplode(permutation:EnumExplode)
    {
        this.explode = permutation;
    }

    public function getPoolSize():Int
    {
        throw new NotImplemented();
    }

    public function getExplode():EnumExplode
    {
        return this.explode;
    }
}
