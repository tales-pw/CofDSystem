package pw.tales.cofdsystem.action.opposition;

import pw.tales.cofdsystem.action.opposition.base.Opposition;
import pw.tales.cofdsystem.action.opposition.pool.ActionPool;
import pw.tales.cofdsystem.game_object.GameObject;

class NoRoll extends Opposition {
    public function new(actor:GameObject) {
        super(new ActionPool(actor, []));
    }

    public override function willRoll(roll:ActionPool) {
        return false;
    }

    override public function roll(action:IAction):Void {
        var system = action.getSystem();
    }
}
