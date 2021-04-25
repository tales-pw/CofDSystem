package pw.tales.cofdsystem.equipment;

import pw.tales.cofdsystem.equipment.traits.Equippable;
import pw.tales.cofdsystem.equipment.traits.HoldingHand;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.prefabs.Accessor;

class Equipment extends Accessor {
    private function new(gameObject:GameObject) {
        super(gameObject);
    }

    private function ensureEquipable():Equippable {
        return this.getTrait(Equippable.TYPE);
    }

    private function ensureHoldingHand():HoldingHand {
        return this.getTrait(HoldingHand.TYPE);
    }
}
