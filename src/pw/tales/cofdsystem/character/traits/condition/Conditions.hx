package pw.tales.cofdsystem.character.traits.condition;

import pw.tales.cofdsystem.character.traits.condition.events.ConditionsCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

@:expose("Conditions")
class Conditions {
    public static function collect(gameObject:GameObject):Array<Condition> {
        var event = new ConditionsCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
