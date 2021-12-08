package pw.tales.cofdsystem.action.pool.exceptions;

import pw.tales.cofdsystem.exceptions.CofDSystemException;

@:expose("PoolNotRolledException")
class PoolNotRolledException extends CofDSystemException
{
    private var pool:ActionPool;

    public function new(pool:ActionPool)
    {
        super("Pool is not rolled yet.");
        this.pool = pool;
    }
}
