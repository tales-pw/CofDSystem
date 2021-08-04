package pw.tales.cofdsystem.scene.turns.events;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.scene.turns.Turns;

class TurnEvent extends TurnsEvent
{
    private final gameObject:GameObject;

    public function new(intitiative:Turns, gameObject:GameObject)
    {
        super(intitiative);
        this.gameObject = gameObject;
    }

    public function getCharacter():GameObject
    {
        return this.gameObject;
    }

    public function isRelated(character:GameObject):Bool
    {
        return this.gameObject == gameObject;
    }

    public static function START(intitiative:Turns, gameObject:GameObject):TurnStartEvent
    {
        return new TurnStartEvent(intitiative, gameObject);
    }

    public static function END(intitiative:Turns, gameObject:GameObject):TurnEndEvent
    {
        return new TurnEndEvent(intitiative, gameObject);
    }
}
