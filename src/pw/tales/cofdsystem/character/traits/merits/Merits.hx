package pw.tales.cofdsystem.character.traits.merits;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.merits.events.MeritsCollectEvent;

@:expose("Merits")
class Merits
{
    public static function collect(gameObject:GameObject):Array<Merit>
    {
        var event = new MeritsCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
