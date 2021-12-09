package pw.tales.cofdsystem.game_object.traits.expression;

import pw.tales.cofdsystem.utils.events.IEvent;
import pw.tales.cofdsystem.game_object.events.TraitModEvent;
import pw.tales.cofdsystem.dices.pool.IPoolBuilder;
import pw.tales.cofdsystem.utils.math.IMathOperation;

class ExpressionTrait extends Trait
{
    private final pool:IMathOperation<Int>;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>,
        poolBuilder:IPoolBuilder
    )
    {
        super(dn, gameObject, type);
        this.pool = poolBuilder.build(gameObject);
    }

    override public function getValue():Int
    {
        var event = new TraitModEvent(gameObject, this);
        this.gameObject.getSystem().events.post(event);
        return pool.calculate() + event.getModifier();
    }

    public override function shouldUpdateView(event:IEvent):Bool
    {
        return true;
    }
}
