package pw.tales.system.action.opposition;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action.events.roll.ActionPostRollEvent;
import pw.tales.system.action.events.roll.ActionPreRollEvent;
import pw.tales.system.action.opposition.base.Opposition;
import pw.tales.system.action.opposition.pool.ActionPool;

class Simple extends Opposition {
    private var difficulty:Int;

    public function new(actorRoll:ActionPool, difficulty:Int) {
        super(actorRoll);
        this.difficulty = difficulty;
    }

    override public function roll(action:IAction):Void {
        var system = action.getSystem();

        system.events.post(new ActionBuildPoolEvent(action, actorPool));

        this.actorPool.getRequest().addModifier(difficulty, "difficulty");

        system.events.post(new ActionPreRollEvent(action, actorPool));
        this.actorPool.roll(system);
        system.events.post(new ActionPostRollEvent(action, actorPool));
    }
}
