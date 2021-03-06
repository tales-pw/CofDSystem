package pw.tales.cofdsystem.game_object.traits.advantages;

import pw.tales.cofdsystem.dices.pool.IPoolBuilder;
import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.utils.math.IMathOperation;

class AdvantageExpression extends Advantage
{
    private final pool:IMathOperation<Int>;

    public function new(gameObject:GameObject, type:TraitType<Dynamic>, poolBuilder:IPoolBuilder)
    {
        super(gameObject, type);
        this.pool = poolBuilder.build(gameObject);
    }

    override public function getValue():Int
    {
        var event = new AdvantageModEvent(gameObject, this);
        this.gameObject.getSystem().events.post(event);
        return pool.calculate() + event.getModifier();
    }
}
