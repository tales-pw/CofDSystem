package pw.tales.system.action.opposition;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action.events.roll.ActionPostRollEvent;
import pw.tales.system.action.events.roll.ActionPreRollEvent;
import pw.tales.system.action.IAction;
import pw.tales.system.action.opposition.base.OppositionCompetitive;
import pw.tales.system.action.opposition.pool.ActionPool;

class Contested extends OppositionCompetitive {
    override public function getWinnerPool():ActionPool {
        var actorRollResponse = actorPool.getResponse();
        var targetRollResponse = targetPool.getResponse();

        if (actorRollResponse.getSuccesses() > targetRollResponse.getSuccesses()) return actorPool;
        return targetPool;
    }

    public override function willRoll(roll:ActionPool) {
        return roll == actorPool || roll == targetPool;
    }

    override public function roll(action:IAction, system:CofDSystem):Void {
        system.events.post(new ActionBuildPoolEvent(action, actorPool, system));
        system.events.post(new ActionBuildPoolEvent(action, targetPool, system));

        system.events.post(new ActionPreRollEvent(action, actorPool, system));
        this.actorPool.roll(system);
        system.events.post(new ActionPostRollEvent(action, actorPool, system));

        system.events.post(new ActionPreRollEvent(action, targetPool, system));
        this.targetPool.roll(system);
        system.events.post(new ActionPostRollEvent(action, targetPool, system));
    }
}
