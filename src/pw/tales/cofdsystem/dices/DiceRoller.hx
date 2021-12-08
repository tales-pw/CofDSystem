package pw.tales.cofdsystem.dices;

import pw.tales.cofdsystem.dices.EnumExplode.EnumExplode;

@:expose("DiceRoller")
class DiceRoller
{
    public function new() {}

    public function d10():Int
    {
        return 1 + Std.random(10);
    }

    private function rollChanceDice():RollResponse
    {
        var diceResult = d10();
        var result = EnumResult.FAILURE;
        var successes = 0;

        if (diceResult == 1)
            result = EnumResult.DRAMATIC_FAILURE;
        if (diceResult == 10)
        {
            successes = 1;
            result = EnumResult.SUCCESS;
        }

        return new RollResponse(result, successes, 0, [diceResult]);
    }

    private function rollDices(poolSize:Int):Array<Int>
    {
        var results:Array<Int> = [];

        for (i in 0...poolSize)
        {
            var result = d10();
            results.push(result);
        }

        return results;
    }

    private function getRepeats(diceResults:Array<Int>, permutation:EnumExplode, stage:Int):Int
    {
        if (permutation == EnumExplode.NONE)
        {
            return 0;
        }

        if (permutation == EnumExplode.ROTE_ACTION)
        {
            if (stage > 0)
                return 0;
            return diceResults.filter(function(v) return v < 7).length;
        }

        return diceResults.filter(function(v) return v >= permutation.getExplode()).length;
    }

    public function defineResult(successes:Int, threshold:Int):EnumResult
    {
        if (successes >= threshold)
            return EnumResult.EXCEPTIONAL_SUCCESS;
        if (successes >= 1)
            return EnumResult.SUCCESS;

        return EnumResult.FAILURE;
    }

    private function rollDicePool(poolRequest:IRollRequest):RollResponse
    {
        var permutation = poolRequest.getExplode();

        var results:Array<Int> = [];
        var toRoll = poolRequest.getPoolSize();
        var stage = 0;

        while (toRoll != 0)
        {
            var diceResults:Array<Int> = this.rollDices(toRoll);
            toRoll = this.getRepeats(diceResults, permutation, stage++);
            results = results.concat(diceResults);
        }

        var successes = results.filter(function(v) return v >= 8).length;

        return new RollResponse(
            this.defineResult(successes, poolRequest.getThreshold()),
            successes,
            poolRequest.getPoolSize(),
            results
        );
    }

    public function roll(request:IRollRequest):RollResponse
    {
        if (request.getPoolSize() < 1)
        {
            return rollChanceDice();
        }

        return rollDicePool(request);
    }
}
