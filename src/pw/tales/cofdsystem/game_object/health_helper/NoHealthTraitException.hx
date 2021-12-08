package pw.tales.cofdsystem.game_object.health_helper;

import pw.tales.cofdsystem.game_object.exceptions.GameObjectException;

@:expose("NoHealthTraitException")
class NoHealthTraitException extends GameObjectException
{
    public function new(gameObject:GameObject)
    {
        super(
            gameObject,
            '${gameObject} have no health trait.'
        );
    }
}
