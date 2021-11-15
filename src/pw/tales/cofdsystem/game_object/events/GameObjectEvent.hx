package pw.tales.cofdsystem.game_object.events;

import pw.tales.cofdsystem.game_object.GameObject;

/**
    Common class for all (most) GameObject-related events to extend from.
    Never instantiated by itself, consider it abstract, avoid subscribing
    to it, better use IGameObjectEvent, otherwise you may miss some events.
**/
@:expose("GameObjectEvent")
class GameObjectEvent implements IGameObjectEvent
{
    private final gameObject:GameObject;

    public function new(gameObject:GameObject)
    {
        this.gameObject = gameObject;
    }

    public function getGameObject():GameObject
    {
        return this.gameObject;
    }

    public function isRelated(gameObject:GameObject):Bool
    {
        return this.gameObject == gameObject;
    }
}
