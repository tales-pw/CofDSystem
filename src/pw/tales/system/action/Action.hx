package pw.tales.system.action;

import pw.tales.system.action.opposition.base.Opposition;
import pw.tales.system.scene.Scene;

class Action implements IAction {
    private final opposition:Opposition;
    private final time:EnumTime;

    private var modifications:Array<IModification> = [];

    private function new(opposition:Opposition, time:EnumTime) {
        this.opposition = opposition;
        this.time = time;
    }

    public function addModification(modification:IModification) {
        this.modifications.push(modification);
    }

    public function getModifications():Array<IModification> {
        return this.modifications;
    }

    public function getOpposition():Opposition {
        return this.opposition;
    }

    public function getActionTime():EnumTime {
        return this.time;
    }

    private function before(system:CofDSystem, scene:Null<Scene> = null) {
        for (modification in this.modifications) modification.before(this);
    }

    private function after(system:CofDSystem, scene:Null<Scene> = null) {
        for (modification in this.modifications) modification.after(this);
    }

    private function roll(system:CofDSystem, scene:Null<Scene> = null) {
        this.opposition.roll(this, system);
    }

    private function perform(system:CofDSystem, scene:Null<Scene> = null) {

    }

    public function execute(system:CofDSystem, scene:Null<Scene> = null):Void {
        this.before(system, scene);
        this.roll(system, scene);
        this.perform(system, scene);
        this.after(system, scene);
    }
}
