package pw.tales.cofdsystem.weapon.traits;

import pw.tales.cofdsystem.utils.events.HandlerPriority;
import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.action.IAction;
import pw.tales.cofdsystem.action.pool.ActionPool;
import pw.tales.cofdsystem.equipment.traits.EquipmentTrait;

class WeaponTrait extends EquipmentTrait
{
    public static final PRIORITY = HandlerPriority.NORMAL;

    public function isHolderPool(pool:ActionPool):Bool
    {
        var holder = this.getHolder();
        return pool.getGameObject() == holder;
    }

    public function isActionWithWeapon(attack:AttackAction):Bool
    {
        var weapon = attack.getWeapon();

        if (weapon == null)
        {
            return false;
        }

        return weapon.getGameObject() == this.gameObject;
    }

    /**
        Checks if this action is attack of weapon's holder.

        @param  event  Event to check.

        @returns True if action is holder's attack.
    **/
    public function isHolderAttack(action:IAction):Bool
    {
        var attack = Utility.downcast(action, AttackAction);

        // Is this attack action.
        if (attack == null)
            return false;

        // Is holder actor in this Action.
        if (action.getActor() != this.getHolder())
            return false;

        // Is this attack with this weapon.
        if (!this.isActionWithWeapon(attack))
            return false;

        return true;
    }

    public function isHolderDefence(action:IAction):Bool
    {
        var attack = Utility.downcast(action, AttackAction);

        // Is this attack action.
        if (attack == null)
            return false;

        // Is holder target in this Action.
        if (attack.getTarget() != this.getHolder())
            return false;

        return true;
    }
}
