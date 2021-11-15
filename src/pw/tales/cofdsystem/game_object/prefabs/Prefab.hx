package pw.tales.cofdsystem.game_object.prefabs;

import pw.tales.cofdsystem.utils.Utility;
import thx.error.NotImplemented;
import thx.Uuid;

@:structInit @:expose("Prefab")
class Prefab implements IPrefab
{
    private final dn:String;

    public function getDN():String
    {
        return this.dn;
    }

    private function setUpGameObject(gameObject:GameObject):Void
    {
        throw new NotImplemented();
    }

    public function createGameObject(system:CofDSystem):GameObject
    {
        final gameObject = new GameObject(Uuid.create(), system);
        gameObject.setState(GameObjectState.LOADING);

        this.setUpGameObject(gameObject);

        gameObject.setState(GameObjectState.ACTIVE);
        return gameObject;
    }

    public function toString():String
    {
        var clazz = Type.getClass(this);
        return '${Utility.getClassName(clazz)}[dn=${dn}]';
    }
}
