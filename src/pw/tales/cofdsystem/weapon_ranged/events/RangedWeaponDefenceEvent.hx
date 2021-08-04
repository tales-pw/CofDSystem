package pw.tales.cofdsystem.weapon_ranged.events;

import pw.tales.cofdsystem.game_object.events.GameObjectEvent;

class RangedWeaponDefenceEvent extends GameObjectEvent
{
    private var canApply:Bool = false;

    public function getCanApply():Bool
    {
        return this.canApply;
    }

    public function setCanApply(canApply:Bool):Void
    {
        this.canApply = canApply;
    }
}
