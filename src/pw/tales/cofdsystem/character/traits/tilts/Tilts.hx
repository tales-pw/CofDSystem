package pw.tales.cofdsystem.character.traits.tilts;

import pw.tales.cofdsystem.character.traits.tilts.events.TiltsCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

@:expose("Tilts")
class Tilts
{
    public static function collect(gameObject:GameObject):Array<Tilt>
    {
        var event = new TiltsCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
