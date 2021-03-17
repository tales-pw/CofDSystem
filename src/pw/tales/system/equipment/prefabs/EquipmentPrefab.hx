package pw.tales.system.equipment.prefabs;

import pw.tales.system.equipment.traits.Equippable;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.prefabs.Prefab;

class EquipmentPrefab extends Prefab {
    private override function setUpGameObject(equipmentGameObject:GameObject) {
        final manager = equipmentGameObject.getTraitManager();
        manager.addTrait(Equippable.TYPE);
    }
}
