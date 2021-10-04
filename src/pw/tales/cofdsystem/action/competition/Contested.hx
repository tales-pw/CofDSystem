package pw.tales.cofdsystem.action.competition;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.pool.ActionPool;
import pw.tales.cofdsystem.action.IAction;

class Contested extends Competition
{
    override public function getWinnerPool():ActionPool
    {
        var actorRollResponse = actorPool.getResponse();
        var targetRollResponse = targetPool.getResponse();

        if (actorRollResponse.getSuccesses() > targetRollResponse.getSuccesses())
            return actorPool;

        return targetPool;
    }

    public override function willRoll(roll:ActionPool):Bool
    {
        return roll == this.actorPool || roll == this.targetPool;
    }

    override public function roll(action:IAction):Void
    {
        var system = action.getSystem();

        system.events.post(new ActionBuildPoolEvent(action, this.actorPool));
        system.events.post(new ActionBuildPoolEvent(action, this.targetPool));

        this.actorPool.roll(action);
        this.targetPool.roll(action);
    }
}
