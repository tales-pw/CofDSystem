package pw.tales.system.equipment;

import pw.tales.system.equipment.exceptions.NotEquippableException;
import pw.tales.system.equipment.exceptions.NotHoldedException;
import pw.tales.system.equipment.traits.Equippable;
import pw.tales.system.equipment.traits.HoldingHand;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.prefabs.Accessor;

class Equipment extends Accessor {
    private function new(gameObject:GameObject) {
        super(gameObject);
    }

    private function ensureEquipable():Equippable {
        var equippable:Null<Equippable> = cast this.traitManager.getTrait(Equippable.TYPE);
        if (equippable == null) throw new NotEquippableException(this.gameObject);
        return equippable;
    }

    private function ensureHoldingHand():HoldingHand {
        var holdingHand:Null<HoldingHand> = cast this.traitManager.getTrait(HoldingHand.TYPE);
        if (holdingHand == null) throw new NotHoldedException(this.gameObject);
        return holdingHand;
    }
}
