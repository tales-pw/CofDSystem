package pw.tales.system.game_object.traits.advantages;

import pw.tales.system.game_object.events.AdvantageModEvent;
import pw.tales.system.game_object.GameObject;

class AdvantageConstant extends Advantage {
    private final value:Int;

    public function new(gameObject:GameObject, type:TraitType<Dynamic>, value:Int) {
        super(gameObject, type);
        this.value = value;
    }

    override public function getValue():Int {
        var event = new AdvantageModEvent(gameObject, this);
        this.eventBus.post(event);
        return value + event.getModifier();
    }
}
