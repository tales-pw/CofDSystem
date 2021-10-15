package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.common.EnumHand;
import pw.tales.cofdsystem.equipment.traits.Equippable;
import pw.tales.cofdsystem.equipment.traits.HoldingHand;
import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.events.IEvent;
import pw.tales.cofdsystem.utils.events.SubEventBus;

class EquipmentTrait extends Trait
{
    private final holderEventBus:SubEventBus;

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.holderEventBus = new SubEventBus(this.system.events, this.filterHolderEvent);
    }

    private function getHolder():Null<GameObject>
    {
        var equippable = this.gameObject.getTrait(Equippable.TYPE);
        if (equippable == null)
            return null;
        return equippable.getHolder();
    }

    private function getHand():Null<EnumHand>
    {
        var holdingHang = this.gameObject.getTrait(HoldingHand.TYPE);
        if (holdingHang == null)
            return null;
        return holdingHang.getHand();
    }

    private function filterHolderEvent(event:IEvent):Bool
    {
        var holder = this.getHolder();
        if (holder == null)
            return false;
        var e:IGameObjectEvent = Std.downcast(event, IGameObjectEvent);
        return e != null && e.isRelated(holder);
    }

    override public function onRemoved():Void
    {
        this.holderEventBus.disable();
        super.onRemoved();
    }
}
