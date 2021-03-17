package pw.tales.system.equipment.traits;

import pw.tales.system.common.EnumHand;
import pw.tales.system.equipment.traits.Equippable;
import pw.tales.system.equipment.traits.HoldingHand;
import pw.tales.system.game_object.events.IGameObjectEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.Trait;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.events.IEvent;
import pw.tales.system.utils.events.SubEventBus;

class EquipmentTrait extends Trait {
    private final holderEventBus:SubEventBus;

    public function new<T:EquipmentTrait>(dn:String, gameObject:GameObject, type:TraitType<T>) {
        super(dn, gameObject, type);
        this.holderEventBus = new SubEventBus(this.system.events, this.filterHolderEvent);
    }

    private function getHolder():Null<GameObject> {
        var equippable:Equippable = cast(this.gameObject.getTraitManager().getTrait(Equippable.TYPE));
        if (equippable == null) return null;
        return equippable.getHolder();
    }

    private function getHand():Null<EnumHand> {
        var holdingHang:HoldingHand = cast(this.gameObject.getTraitManager().getTrait(HoldingHand.TYPE));
        if (holdingHang == null) return null;
        return holdingHang.getHand();
    }

    private function filterHolderEvent(event:IEvent):Bool {
        var holder = this.getHolder();
        if (holder == null) return false;
        var e:IGameObjectEvent = Std.downcast(event, IGameObjectEvent);
        return e != null && e.isRelated(holder);
    }

    override public function onRemoved() {
        this.holderEventBus.disable();
        super.onRemoved();
    }
}
