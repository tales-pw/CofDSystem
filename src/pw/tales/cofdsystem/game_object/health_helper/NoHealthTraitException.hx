package pw.tales.cofdsystem.game_object.health_helper;

import pw.tales.cofdsystem.game_object.exceptions.GameObjectException;

class NoHealthTraitException extends GameObjectException
{
    public function new(gameObject:GameObject)
    {
        super(gameObject, '${gameObject} have no health trait.');
    }
}
