package pw.tales.cofdsystem.action.opposition;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.events.roll.ActionPostRollEvent;
import pw.tales.cofdsystem.action.events.roll.ActionPreRollEvent;
import pw.tales.cofdsystem.action.IAction;
import pw.tales.cofdsystem.action.opposition.base.OppositionCompetitive;
import pw.tales.cofdsystem.action.opposition.pool.ActionPool;

class Contested extends OppositionCompetitive
{
    override public function getWinnerPool():ActionPool
    {
        var actorRollResponse = actorPool.getResponse();
        var targetRollResponse = targetPool.getResponse();

        if (actorRollResponse.getSuccesses() > targetRollResponse.getSuccesses())
            return actorPool;
        return targetPool;
    }

    public override function willRoll(roll:ActionPool)
    {
        return roll == actorPool || roll == targetPool;
    }

    override public function roll(action:IAction):Void
    {
        var system = action.getSystem();

        system.events.post(new ActionBuildPoolEvent(action, actorPool));
        system.events.post(new ActionBuildPoolEvent(action, targetPool));

        system.events.post(new ActionPreRollEvent(action, actorPool));
        this.actorPool.roll(system);
        system.events.post(new ActionPostRollEvent(action, actorPool));

        system.events.post(new ActionPreRollEvent(action, targetPool));
        this.targetPool.roll(system);
        system.events.post(new ActionPostRollEvent(action, targetPool));
    }
}
