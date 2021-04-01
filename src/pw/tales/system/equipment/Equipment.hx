package pw.tales.system.equipment;

import pw.tales.system.equipment.traits.Equippable;
import pw.tales.system.equipment.traits.HoldingHand;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.prefabs.Accessor;

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
