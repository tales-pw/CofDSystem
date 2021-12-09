package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.common.traits.advantages.IAdvantage;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTraitType;
import pw.tales.cofdsystem.game_object.traits.value_trait.ValueTrait;
import pw.tales.cofdsystem.character.advancement.generation.events.GenMeritCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

@RegisterTraitTypes
@:expose("WealthAdvantage")
class WealthAdvantage extends ValueTrait implements IAdvantage
{
    public static final DN = "Богатство";
    public static final TYPE = ValueTraitType.createType(DN, WealthAdvantage.new);

    public static final DEFAULT = 0;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:ValueTraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, DEFAULT);
        this.eventBus.addHandler(GenMeritCollectEvent, this.collect);
    }
}
