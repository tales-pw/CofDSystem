package pw.tales.system.action.opposition;

import pw.tales.system.action.opposition.base.Opposition;
import pw.tales.system.action.opposition.pool.ActionPool;
import pw.tales.system.game_object.GameObject;

class NoRoll extends Opposition {
    public function new(actor:GameObject) {
        super(new ActionPool(actor, []));
    }

    public override function willRoll(roll:ActionPool) {
        return false;
    }

    override public function roll(action:IAction, system:CofDSystem):Void {
    }
}
