package pw.tales.cofdsystem.game_object.traits.advantages;

import pw.tales.cofdsystem.utils.events.IEvent;

@:expose("Advantage")
class Advantage extends Trait
{
    override public function shouldUpdateView(event:IEvent):Bool
    {
        return true;
    }
}
