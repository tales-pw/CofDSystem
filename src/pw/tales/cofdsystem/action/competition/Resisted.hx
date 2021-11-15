package pw.tales.cofdsystem.action.competition;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.events.pool.ActionBuildResistEvent;
import pw.tales.cofdsystem.action.pool.ActionPool;
import pw.tales.cofdsystem.dices.EnumResult;

@:expose("Resisted")
class Resisted extends Competition
{
    override public function getWinnerPool():ActionPool
    {
        var result = this.actorPool.getResponse().getResult();

        if (EnumResult.isSuccess(result))
            return this.actorPool;

        return this.targetPool;
    }

    public override function willRoll(roll:ActionPool):Bool
    {
        return roll == this.actorPool;
    }

    override public function roll(action:RollAction):Void
    {
        var system = action.getSystem();

        system.events.post(new ActionBuildPoolEvent(action, this.actorPool));
        system.events.post(new ActionBuildResistEvent(action, this.targetPool));

        var resist = targetPool.getRequest().getPoolSize();
        this.actorPool.getRequest().addModifier(-resist, "resist");

        this.actorPool.rollWithPoolEvents(action);
    }
}
