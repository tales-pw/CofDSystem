package pw.tales.cofdsystem.game_object.exceptions;

import pw.tales.cofdsystem.exceptions.CofDSystemException;

@:expose("GameObjectException")
class GameObjectException extends CofDSystemException
{
    private final gameObject:GameObject;

    public function new(gameObject:GameObject, msg:String, ?previous:haxe.Exception)
    {
        super(msg, previous);
        this.gameObject = gameObject;
    }
}
