package pw.tales.cofdsystem.scene.initiative.exceptions;

import pw.tales.cofdsystem.game_object.GameObject;

class AddedAgainException extends InitiativeException
{
    private final gameObject:GameObject;
    private final turnOrder:Initiative;

    public function new(gameObject:GameObject, initiative:Initiative)
    {
        super('${gameObject} is already in initiative.');
        this.gameObject = gameObject;
        this.turnOrder = initiative;
    }
}
