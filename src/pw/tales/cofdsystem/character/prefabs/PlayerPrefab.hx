package pw.tales.cofdsystem.character.prefabs;

import pw.tales.cofdsystem.character.traits.Experience;
import pw.tales.cofdsystem.game_object.GameObject;

@:structInit @:expose("PlayerPrefab")
class PlayerPrefab extends HumanPrefab
{
    public static final INSTANCE:PlayerPrefab = {
        dn: "player"
    };

    private override function setUpGameObject(gameObject:GameObject):Void
    {
        super.setUpGameObject(gameObject);

        var traitManager = gameObject.getTraitManager();
        traitManager.addTrait(Experience.TYPE);
    }
}
