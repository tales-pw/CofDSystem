package pw.tales.system.action;

import pw.tales.system.action.opposition.NoRoll;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.scene.Scene;

class NoRollAction extends Action {
    private final actor:GameObject;

    private function new(actor:GameObject, time:EnumTime) {
        super(new NoRoll(actor), time);
        this.actor = actor;
    }

    override public function execute(system:CofDSystem, scene:Null<Scene> = null):Void {
    }
}
