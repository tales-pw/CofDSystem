package pw.tales.cofdsystem.scene.events;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;

class SceneEvent implements IGameObjectEvent
{
    private final scene:Scene;

    public function new(scene:Scene)
    {
        this.scene = scene;
    }

    public static function START(scene:Scene):SceneStartEvent
    {
        return new SceneStartEvent(scene);
    }

    public static function END(scene:Scene):SceneEndEvent
    {
        return new SceneEndEvent(scene);
    }

    public function isRelated(gameObject:GameObject):Bool
    {
        return scene.getInitiative().getOrder().contains(gameObject);
    }
}
