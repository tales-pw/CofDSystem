package pw.tales.cofdsystem.action;

import pw.tales.cofdsystem.action.opposition.NoRoll;
import pw.tales.cofdsystem.game_object.GameObject;

class NoRollAction extends Action {
    private final actor:GameObject;

    private function new(actor:GameObject, time:EnumTime, system:CofDSystem) {
        super(new NoRoll(actor), time, system);
        this.actor = actor;
    }

    override public function roll():Void {
    }
}
