package pw.tales.cofdsystem.dices.pool.math;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

@:expose("PoolTrait")
class PoolTrait implements IMathOperation<Int>
{
    private final gameObject:GameObject;
    private final dn:String;

    public function new(gameObject:GameObject, dn:String)
    {
        this.gameObject = gameObject;
        this.dn = dn;
    }

    public function getOperands():Array<IMathOperation<Dynamic>>
    {
        return [];
    }

    public function calculate():Int
    {
        return this.gameObject.getTraitManager().getValue(this.dn);
    }
}
