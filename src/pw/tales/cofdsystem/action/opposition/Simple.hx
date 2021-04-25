package pw.tales.cofdsystem.action.opposition;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.events.roll.ActionPostRollEvent;
import pw.tales.cofdsystem.action.events.roll.ActionPreRollEvent;
import pw.tales.cofdsystem.action.opposition.base.Opposition;
import pw.tales.cofdsystem.action.opposition.pool.ActionPool;

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
