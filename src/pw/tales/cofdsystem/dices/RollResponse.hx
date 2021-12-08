package pw.tales.cofdsystem.dices;

@:expose("RollResponse")
class RollResponse
{
    private var result:EnumResult;
    private var successes:Int;
    private var poolSize:Int;
    private var results:Array<Int>;

    public function new(result:EnumResult, successes:Int, poolSize:Int, results:Array<Int>)
    {
        this.result = result;
        this.successes = successes;
        this.poolSize = poolSize;
        this.results = results;
    }

    public function setResult(result:EnumResult):Void
    {
        this.result = result;
    }

    public function getResult():EnumResult
    {
        return this.result;
    }

    public function setSuccesses(successes:Int):Void
    {
        this.successes = successes;
    }

    public function getSuccesses():Int
    {
        return this.successes;
    }

    public function getPoolSize():Int
    {
        return this.poolSize;
    }

    public function getResults():Array<Int>
    {
        return this.results;
    }

    public function toString():String
    {
        return Std.string({
            "result": this.result,
            "successes": this.successes,
            "poolSize": this.poolSize,
            "results": this.results
        });
    }
}
