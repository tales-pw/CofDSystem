package pw.tales.cofdsystem.dices.pool.builder;

import pw.tales.cofdsystem.dices.pool.math.PoolTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

class PBTrait extends PoolBuilder
{
    private final dn:String;

    public function new(dn:String)
    {
        super();
        this.dn = dn;
    }

    override public function getHumanReadable():String
    {
        return Std.string(this.dn);
    }

    override public function build(gameObject:GameObject):IMathOperation<Int>
    {
        return new PoolTrait(gameObject, this.dn);
    }
}
