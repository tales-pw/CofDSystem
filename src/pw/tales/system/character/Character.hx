package pw.tales.system.character;

import pw.tales.system.character.prefabs.HumanPrefab;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.prefabs.Accessor;

class Character extends Accessor {
    public function new(gameObject:GameObject) {
        super(gameObject);
    }

    public function getName():String {
        return this.getText(HumanPrefab.NAME);
    }
}
