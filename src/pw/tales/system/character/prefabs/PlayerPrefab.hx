package pw.tales.system.character.prefabs;

import pw.tales.system.character.traits.Experience;
import pw.tales.system.game_object.GameObject;

class PlayerPrefab extends HumanPrefab {
    public static final INSTANCE = new PlayerPrefab("player");

    private override function setUpGameObject(gameObject:GameObject) {
        super.setUpGameObject(gameObject);

        var traitManager = gameObject.getTraitManager();
        traitManager.addTrait(Experience.TYPE);
    }
}
