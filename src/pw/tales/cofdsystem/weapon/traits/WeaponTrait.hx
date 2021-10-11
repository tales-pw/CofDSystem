package pw.tales.cofdsystem.weapon.traits;

import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.action.events.ActionGetHandEvent;
import pw.tales.cofdsystem.action.IAction;
import pw.tales.cofdsystem.action.pool.ActionPool;
import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.equipment.traits.EquipmentTrait;

class WeaponTrait extends EquipmentTrait
{
    private function getActionHand(action:IAction):EnumHand
    {
        var eventBus = action.getEventBus();
        var actor = action.getActor();

        var handEvent = new ActionGetHandEvent(action, actor);
        eventBus.post(handEvent);

        return handEvent.getHand();
    }

    public function isHolderPool(pool:ActionPool):Bool
    {
        var holder = this.getHolder();
        return pool.getGameObject() == holder;
    }

    public function isActionWithWeapon(action:IAction):Bool
    {
        var weaponHand = this.getHand();
        var actionHand = this.getActionHand(action);
        return weaponHand != null && weaponHand == actionHand;
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
        if (!this.isActionWithWeapon(action))
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
