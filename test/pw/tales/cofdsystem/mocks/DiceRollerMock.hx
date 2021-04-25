package pw.tales.cofdsystem.mocks;

import pw.tales.cofdsystem.dices.DiceRoller;

class DiceRollerMock extends DiceRoller {
    public var result:Null<Int>;
    public var results:Array<Int>;

    public function new(results:Array<Int>, ?result:Null<Int>) {
        super();
        this.result = result;
        this.results = results;
    }

    override public function d10():Int {
        var nextRoll:Null<Int> = results.shift();
        if (nextRoll != null) return nextRoll;
        if (result != null) return result;
        throw "No default value for mock set";
    }
}
