package pw.tales.system.weapon.traits;

import pw.tales.system.action.IAction;
import pw.tales.system.action.modifications.Offhand;
import pw.tales.system.action.opposition.pool.ActionPool;
import pw.tales.system.common.EnumHand;
import pw.tales.system.equipment.traits.EquipmentTrait;
import pw.tales.system.utils.Utility;

class WeaponTrait extends EquipmentTrait {
    private function getActionHand(action:IAction):EnumHand {
        var actor = action.getOpposition().getActorPool().getGameObject();

        for (modification in action.getModifications()) {
            var offhand:Null<Offhand> = Utility.downcast(modification, Offhand);
            if (offhand == null) continue;

            var whoseHand = offhand.getGameObject();
            if (whoseHand == actor) return EnumHand.OFFHAND;
        }

        return EnumHand.HAND;
    }

    public function doesHolderAct(action:IAction):Bool {
        var holder = this.getHolder();
        return holder != null && action.getOpposition().getActorPool().getGameObject() == holder;
    }

    public function isHolderPool(pool:ActionPool):Bool {
        var holder = this.getHolder();
        return pool.getGameObject() == holder;
    }

    public function isActionWithWeapon(action:IAction):Bool {
        var weaponHand = this.getHand();
        var actionHand = this.getActionHand(action);
        return weaponHand != null && weaponHand == actionHand;
    }
}
