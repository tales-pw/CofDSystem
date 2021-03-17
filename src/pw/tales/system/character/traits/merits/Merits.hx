package pw.tales.system.character.traits.merits;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.character.traits.merits.events.MeritsCollectEvent;

@:keep
@:expose("Merits")
class Merits {
    public static function collect(gameObject:GameObject):Array<Merit> {
        var event = new MeritsCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
