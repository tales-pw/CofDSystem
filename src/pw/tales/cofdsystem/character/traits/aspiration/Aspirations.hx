package pw.tales.cofdsystem.character.traits.aspiration;

import pw.tales.cofdsystem.character.traits.aspiration.events.AspirationsCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

@RegisterTraitTypes
@:expose("Aspirations")
class Aspirations
{
    public static final TYPE:AspirationType = new AspirationType("Стремление");
    public static final SHORT_TERM_TYPE:AspirationType = new AspirationType("Краткосрочное_Стремление");
    public static final LONG_TERM_TYPE:AspirationType = new AspirationType("Долгосрочное_Стремление");

    public static function collect(gameObject:GameObject):Array<Aspiration>
    {
        var event = new AspirationsCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
