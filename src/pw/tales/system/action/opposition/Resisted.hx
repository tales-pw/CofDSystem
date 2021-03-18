package pw.tales.system.action.opposition;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action.events.pool.ActionBuildResistEvent;
import pw.tales.system.action.events.roll.ActionPostRollEvent;
import pw.tales.system.action.events.roll.ActionPreRollEvent;
import pw.tales.system.action.opposition.base.OppositionCompetitive;
import pw.tales.system.action.opposition.pool.ActionPool;
import pw.tales.system.dices.EnumResult;

class Resisted extends OppositionCompetitive {
    override public function getWinnerPool():ActionPool {
        var result = actorPool.getResponse().getResult();
        if (EnumResult.isSuccess(result)) return actorPool;
        return targetPool;
    }

    public override function willRoll(roll:ActionPool) {
        return roll == actorPool;
    }

    override public function roll(action:IAction):Void {
        var system = action.getSystem();

        system.events.post(new ActionBuildPoolEvent(action, actorPool));
        system.events.post(new ActionBuildResistEvent(action, targetPool));

        var resist = targetPool.getRequest().getPoolSize();
        this.actorPool.getRequest().addModifier(-resist, "resist");

        system.events.post(new ActionPreRollEvent(action, actorPool));
        this.actorPool.roll(system);
        system.events.post(new ActionPostRollEvent(action, actorPool));
    }
}
