package pw.tales.system.game_object.prefabs;

import thx.error.NotImplemented;
import thx.Uuid;

class Prefab implements IPrefab {
    private final dn:String;

    public function new(dn:String) {
        this.dn = dn;
    }

    public function getDN():String {
        return this.dn;
    }

    private function setUpGameObject(gameObject:GameObject) throw new NotImplemented();

    public function createGameObject(system:CofDSystem):GameObject {
        final gameObject = new GameObject(Uuid.create(), system);
        gameObject.setState(GameObjectState.LOADING);

        this.setUpGameObject(gameObject);

        gameObject.setState(GameObjectState.ACTIVE);
        return gameObject;
    }
}
