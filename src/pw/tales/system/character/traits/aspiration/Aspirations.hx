package pw.tales.system.character.traits.aspiration;

import pw.tales.system.character.traits.aspiration.events.AspirationsCollectEvent;
import pw.tales.system.game_object.GameObject;

@:keep
@autoregister
@:expose("Aspirations")
class Aspirations {
    public static final TYPE:AspirationType = new AspirationType("Стремление");
    public static final SHORT_TERM_TYPE:AspirationType = new AspirationType("Краткосрочное_Стремление");
    public static final LONG_TERM_TYPE:AspirationType = new AspirationType("Долгосрочное_Стремление");

    public static function collect(gameObject:GameObject):Array<Aspiration> {
        var event = new AspirationsCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
