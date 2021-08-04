package pw.tales.cofdsystem.character.traits.speciality;

import pw.tales.cofdsystem.character.traits.speciality.events.SpecialitiesCollectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

@:expose("Specialities")
class Specialities
{
    public static function collect(gameObject:GameObject):Array<Speciality>
    {
        var event = new SpecialitiesCollectEvent(gameObject);
        gameObject.getEventBus().post(event);
        return event.getCollected();
    }
}
