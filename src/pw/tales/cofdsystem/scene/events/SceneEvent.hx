package pw.tales.cofdsystem.scene.events;

import pw.tales.cofdsystem.utils.events.IEvent;

class SceneEvent implements IEvent {
    private final scene:Scene;

    public function new(scene:Scene) {
        this.scene = scene;
    }

    public static function START(scene:Scene):SceneStartEvent {
        return new SceneStartEvent(scene);
    }

    public static function END(scene:Scene):SceneEndEvent {
        return new SceneEndEvent(scene);
    }
}
