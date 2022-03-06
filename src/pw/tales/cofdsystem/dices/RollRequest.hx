package pw.tales.cofdsystem.dices;

import pw.tales.cofdsystem.pool.math.PoolTrait;
import pw.tales.cofdsystem.game_object.GameObject;
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

    public function getTraits(gameObject:GameObject):Array<PoolTrait>
    {
        return [];
    }

    public function addModifier(
        value:Int,
        modDn:Null<String> = null,
        gameObject:Null<GameObject> = null
    ):Void
    {
        // TODO: Implement
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
