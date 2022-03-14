package pw.tales.cofdsystem.character.traits.advantages.willpower;

using pw.tales.cofdsystem.time.TimeUtils;
using pw.tales.cofdsystem.pool.PoolBuilderHelper;

import datetime.DateTime;
import pw.tales.cofdsystem.utils.logger.LoggerManager;
import pw.tales.cofdsystem.time.events.TimeUpdateEvent;
import pw.tales.cofdsystem.character.traits.advantages.willpower.exceptions.NoWillpowerException;
import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageExpression;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:rtti
@:expose("WillpowerAdvantage")
class WillpowerAdvantage extends AdvantageExpression
{
    public static final DN = "Сила_воли";
    public static final TYPE = TraitType.createType(DN, WillpowerAdvantage.new);

    public static final RESTORE_INTERVAL = Hour(24).toInterval();

    private static final EXPR = RESOLVE.plus(COMPOSURE);

    @Serialize("points")
    private var points:Null<Int> = null;

    @Serialize("timeUpdated")
    private var timeUpdated:DateTime;

    @:nullSafety(Off)
    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, EXPR);

        this.timeUpdated = this.now();
        this.gEventBus.addHandler(TimeUpdateEvent, this.handleTimeUpdate);
    }

    /* Get amount of willpower restore intervals (24 hours) */
    private function countRestoreIntervals(start:DateTime, end:DateTime):Int
    {
        var totalTime = end - start;
        return totalTime.div(RESTORE_INTERVAL);
    }

    public dynamic function now():DateTime
    {
        return DateTime.now();
    }

    /* Clamp restore amount to a maximum possible value. */
    public function clampRestorePoints(amount:Int):Int
    {
        var points = this.getPoints();
        var maxPoints = this.getValue();

        var maxAmount = maxPoints - points;

        return Std.int(Math.min(maxAmount, amount));
    }

    public function handleTimeUpdate(e:TimeUpdateEvent):Void
    {
        var oldTime = this.timeUpdated;
        var newTime = this.now();

        // Don't try to restore when already full.
        if (this.isFull())
            return;

        // Get amount of willpower restore intervals since last time update.
        var intervals = this.countRestoreIntervals(oldTime, newTime);

        // Not enough time has passed since last update.
        if (intervals < 1)
            return;

        var amount = this.clampRestorePoints(intervals);
        this.restoreWillpower(amount);
    }

    public function isFull():Bool
    {
        return this.getPoints() >= this.getValue();
    }

    public function canUse():Bool
    {
        return this.getPoints() > 0;
    }

    public function getPoints():Int
    {
        if (this.points != null)
            return this.points;
        return this.getValue();
    }

    public function setPoints(points:Int):Void
    {
        this.points = points;
        this.timeUpdated = this.now();
        this.notifyUpdated();
    }

    public function restoreWillpower(amount:Int = 1):Void
    {
        var logger = LoggerManager.getLogger();

        var newPoints = this.getPoints() + amount;
        var maxPoints = this.getValue();

        if (newPoints > maxPoints)
        {
            logger.warning(
                'Clamping willpower $newPoints to $maxPoints.'
            );
            newPoints = this.clampRestorePoints(newPoints);
        }

        logger.info(
            'Restoring $newPoints willpower for ${this.gameObject.getDN()}.'
        );

        this.setPoints(newPoints);
    }

    public function burnWillpower(amount:Int = 1):Void
    {
        var newPoints = this.getPoints() - amount;

        if (newPoints < 0)
        {
            throw new NoWillpowerException(this);
        }

        this.setPoints(newPoints);
    }
}
