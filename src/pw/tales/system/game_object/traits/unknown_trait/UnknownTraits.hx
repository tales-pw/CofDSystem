package pw.tales.system.game_object.traits.unknown_trait;

import pw.tales.system.game_object.traits.unknown_trait.events.UnknownTraitsCollectEvent;

@:expose("UnknownTraits")
class UnknownTraits {
    public static function collect(gameObject:GameObject):Array<UnknownTrait> {
        var event = new UnknownTraitsCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
