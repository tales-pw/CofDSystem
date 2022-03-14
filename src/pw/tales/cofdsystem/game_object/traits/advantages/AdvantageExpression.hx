package pw.tales.cofdsystem.game_object.traits.advantages;

import pw.tales.cofdsystem.pool.builder.IPoolBuilder;
import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;

@:expose("AdvantageExpression")
class AdvantageExpression extends Advantage
{
    private final poolBuilder:IPoolBuilder;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>,
        poolBuilder:IPoolBuilder
    )
    {
        super(dn, gameObject, type);
        this.poolBuilder = poolBuilder;
    }

    override public function getValue():Int
    {
        var event = new AdvantageModEvent(gameObject, this);
        this.system.events.post(event);
        return poolBuilder.calculate(gameObject) + event.getModifier();
    }
}
