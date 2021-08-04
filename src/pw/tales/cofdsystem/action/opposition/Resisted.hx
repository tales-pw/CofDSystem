package pw.tales.cofdsystem.action.opposition;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.events.pool.ActionBuildResistEvent;
import pw.tales.cofdsystem.action.events.roll.ActionPostRollEvent;
import pw.tales.cofdsystem.action.events.roll.ActionPreRollEvent;
import pw.tales.cofdsystem.action.opposition.base.OppositionCompetitive;
import pw.tales.cofdsystem.action.opposition.pool.ActionPool;
import pw.tales.cofdsystem.dices.EnumResult;

class Resisted extends OppositionCompetitive
{
    override public function getWinnerPool():ActionPool
    {
        var result = actorPool.getResponse().getResult();
        if (EnumResult.isSuccess(result))
            return actorPool;
        return targetPool;
    }

    public override function willRoll(roll:ActionPool)
    {
        return roll == actorPool;
    }

    override public function roll(action:IAction):Void
    {
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
