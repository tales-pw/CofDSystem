package pw.tales.cofdsystem.equipment.prefabs;

import pw.tales.cofdsystem.equipment.traits.Equippable;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.prefabs.Prefab;

class EquipmentPrefab extends Prefab {
    private override function setUpGameObject(equipmentGameObject:GameObject) {
        final manager = equipmentGameObject.getTraitManager();
        manager.addTrait(Equippable.TYPE);
    }
}
