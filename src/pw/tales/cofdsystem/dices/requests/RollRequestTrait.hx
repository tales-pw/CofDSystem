package pw.tales.cofdsystem.dices.requests;

import pw.tales.cofdsystem.game_object.GameObject;

class RollRequestTrait extends ABSRollRequest
{
    private var gameObject:GameObject;
    private var traits:Array<String>;

    private var modifiers:Map<String, Array<Int>> = new Map();
    private var ignoreLimit:Array<String> = ["resist", "difficulty"];

    public function new(gameObject:GameObject, traits:Array<String>)
    {
        super();
        this.gameObject = gameObject;
        this.traits = traits;
    }

    public function getTraits():Array<String>
    {
        return this.traits;
    }

    public function setTraits(traits:Array<String>)
    {
        this.traits = traits;
    }

    private function buildPool():Int
    {
        var values = traits.map((trait) -> gameObject.getTraitManager().getValue(trait));
        return Lambda.fold(values, (a, b) -> a + b, 0);
    }

    public function addIgnoreLimit(source:String)
    {
        this.ignoreLimit.push(source);
    }

    public function addModifier(value:Int, source:String)
    {
        if (value == 0)
            return;

        var sourceModifiers = this.modifiers[source];
        if (sourceModifiers != null)
        {
            sourceModifiers.push(value);
        } else
        {
            this.modifiers[source] = [value];
        }
    }

    public function getAppliedModifiers():Map<String, Int>
    {
        var appliedModifiers = new Map<String, Int>();

        for (entry in this.modifiers.keyValueIterator())
        {
            var source = entry.key;
            var sourceModifiers = entry.value;

            var sourceMod = Lambda.fold(sourceModifiers, (a, b) -> a + b, 0);

            if (this.ignoreLimit.indexOf(source) == -1)
            {
                sourceMod = Std.int(Math.max(sourceMod, -5));
                sourceMod = Std.int(Math.min(sourceMod, 5));
            }

            appliedModifiers.set(source, sourceMod);
        }

        return appliedModifiers;
    }

    private function processModifiers():Int
    {
        var appliedModifiers = this.getAppliedModifiers();
        return Lambda.fold(appliedModifiers, (a, b) -> a + b, 0);
    }

    override public function getPoolSize():Int
    {
        var mod = this.processModifiers();
        return Std.int(Math.max(this.buildPool() + mod, 0));
    }
}
