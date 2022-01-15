package pw.tales.cofdsystem.character.traits.advantages.willpower;

import pw.tales.cofdsystem.utils.logger.LoggerManager;
import haxe.Int64;
import thx.DateTime;
import pw.tales.cofdsystem.time.events.TimeUpdateEvent;
import pw.tales.cofdsystem.character.traits.advantages.willpower.exceptions.NoWillpowerException;
import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.dices.pool.builder.PBTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.advantages.AdvantageExpression;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("WillpowerAdvantage")
class WillpowerAdvantage extends AdvantageExpression
{
    public static final DN = "Сила_воли";
    public static final TYPE = TraitType.createType(DN, WillpowerAdvantage.new);

    private static final EXPR = new PBTrait(RESOLVE.getDN()).plus(new PBTrait(COMPOSURE.getDN()));

    @Serialize("points")
    private var points:Null<Int> = null;

    @Optional
    @Serialize("timeUpdated")
    private var timeUpdated:String;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, EXPR);
        this.timeUpdated = DateTime.nowUtc().toString();

        this.eventBus.addHandler(TimeUpdateEvent, this.handleTimeUpdate);
    }

    private function setTimeUpdated(time:DateTime):Void
    {
        this.timeUpdated = time.toString();
        this.notifyUpdated();
    }

    private function getTimeUpdated():DateTime
    {
        return DateTime.fromString(this.timeUpdated);
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
        var newTime = e.getTime();
        var oldTime = this.getTimeUpdated();

        // Don't try to restore when already full.
        if (this.isFull())
        {
            this.setTimeUpdated(newTime);
            return;
        }

        var totalHours = (newTime - oldTime).totalHours;

        // Get amount of willpower restore intervals (24 hours)
        // since last time update.
        var intervals = Int64.div(totalHours, 24).low;

        // Not enough time has passed since last update.
        if (intervals < 1)
            return;

        var amount = this.clampRestorePoints(intervals);
        this.restoreWillpower(amount);

        // Set last update to the end of last interval.
        this.setTimeUpdated(oldTime.addHours(intervals * 24));
    }

    public function isFull():Bool
    {
        return this.getPoints() <= this.getValue();
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
