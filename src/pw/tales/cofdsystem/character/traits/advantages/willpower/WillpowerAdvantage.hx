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
    @Serialize("update")
    private var updated:String;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, EXPR);
        this.updated = DateTime.nowUtc().toString();

        this.eventBus.addHandler(TimeUpdateEvent, this.handleTime);
    }

    public function handleTime(e:TimeUpdateEvent):Void
    {
        // Don't try to restore when already full.
        if (this.isFull())
            return;

        var newTime = e.getTime();
        var oldTime = DateTime.fromString(this.updated);

        var hours = (newTime - oldTime).totalHours;

        var dm = Int64.divMod(hours, 24);

        var intervals = dm.quotient.low;
        var leftover = dm.modulus.low;

        this.restoreWillpower(intervals);

        this.updated = oldTime.addHours(leftover).toString();
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

    public function setPoints(points:Int):Void {
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
            newPoints = maxPoints;
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
