package pw.tales.system.character.traits.speciality;
import pw.tales.system.character.traits.speciality.events.SpecialitiesCollectEvent;
import pw.tales.system.game_object.GameObject;


@:keep
@:expose("Specialities")
class Specialities {
    public static function collect(gameObject:GameObject):Array<Speciality> {
        var event = new SpecialitiesCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
