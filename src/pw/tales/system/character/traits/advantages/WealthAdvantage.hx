package pw.tales.system.character.traits.advantages;

import pw.tales.system.character.advancement.generation.events.GenMeritCollectEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.advantages.Advantage;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.game_object.traits.value_trait.events.ValueTraitUpdateEvent;

@:keep
@:expose("WealthAdvantage")
class WealthAdvantage extends Advantage {
    // TODO: Somehow merge it with ValueTrait. Turning Avdantage into interface is a valid choice.

    public static final DN = "Богатство";
    public static final TYPE = TraitType.createType(DN, create);

    @Serialize("points")
    private var points:Int = 0;

    public function new(gameObject:GameObject) {
        super(gameObject, TYPE);
        this.eventBus.addHandler(GenMeritCollectEvent, (e:GenMeritCollectEvent) -> e.collect(this));
    }

    public function canUpdate(newValue:Int):Bool {
        var event = new ValueTraitUpdateEvent(this, newValue);
        this.system.events.post(event);
        return !event.isCancelled();
    }

    public function setValue(points:Int):Void {
        if (!this.canUpdate(points)) return;
        this.points = points;
        this.notifyUpdated();
    }

    public override function getValue():Int {
        return this.points;
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<WealthAdvantage>):WealthAdvantage {
        return new WealthAdvantage(gameObject);
    }
}
