package pw.tales.cofdsystem.character.traits.advantages;

import pw.tales.cofdsystem.character.advancement.generation.events.GenMeritCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.Advantage;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.game_object.traits.value_trait.events.ValueTraitUpdateEvent;

@RegisterTraitTypes
@:expose("WealthAdvantage")
class WealthAdvantage extends Advantage
{
    // TODO: Somehow merge it with ValueTrait. Turning Avdantage into interface is a valid choice.
    public static final DN = "Богатство";
    public static final TYPE = TraitType.createType(DN, WealthAdvantage.new);

    @Serialize("points")
    private var points:Int = 0;

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.eventBus.addHandler(GenMeritCollectEvent, this.collect);
    }

    public function canUpdate(newValue:Int):Bool
    {
        var event = new ValueTraitUpdateEvent(this, newValue);
        this.system.events.post(event);
        return !event.isCancelled();
    }

    public function setValue(points:Int):Void
    {
        if (!this.canUpdate(points))
            return;
        this.points = points;
        this.notifyUpdated();
    }

    public override function getValue():Int
    {
        return this.points;
    }
}
