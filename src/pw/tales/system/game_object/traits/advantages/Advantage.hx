package pw.tales.system.game_object.traits.advantages;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.utils.events.IEvent;

class Advantage extends Trait {
    public function new<T: Advantage>(gameObject:GameObject, type:TraitType<T>) {
        super(type.getDN(), gameObject, type);
    }

    override public function shouldUpdateView(event:IEvent):Bool {
        return true;
    }
}
