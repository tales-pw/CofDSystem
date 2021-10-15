package pw.tales.cofdsystem.equipment.events;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.events.GameObjectEvent;

class StrengthReqEvent extends GameObjectEvent
{
    private var value:Int;

    public function new(gameObject:GameObject, value:Int)
    {
        super(gameObject);
        this.value = value;
    }

    public function getValue():Int
    {
        return this.value;
    }

    public function setValue(value:Int):Void
    {
        this.value = value;
    }
}
