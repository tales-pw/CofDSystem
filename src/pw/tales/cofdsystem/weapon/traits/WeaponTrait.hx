package pw.tales.cofdsystem.weapon.traits;

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

    public function isHolderActor(action:IAction):Bool
    {
        var holder = this.getHolder();
        return holder != null && action.getActor() == holder;
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
}
