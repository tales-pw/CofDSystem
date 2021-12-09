package pw.tales.cofdsystem.character.traits.advantages.health;

import pw.tales.cofdsystem.common.traits.advantages.IAdvantage;
import pw.tales.cofdsystem.game_object.traits.expression.ExpressionTrait;
import pw.tales.cofdsystem.common.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.character.traits.advantages.health.events.GameObjectDamagedEvent;
import pw.tales.cofdsystem.character.traits.advantages.health.events.GameObjectDiedEvent;
import pw.tales.cofdsystem.character.traits.attribute.Attributes.*;
import pw.tales.cofdsystem.damage.Damage;
import pw.tales.cofdsystem.dices.pool.builder.PBTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.health_helper.GetHealthTraitEvent;
import pw.tales.cofdsystem.game_object.health_helper.IHealthTrait;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("HealthAdvantage")
class HealthAdvantage extends ExpressionTrait implements IHealthTrait implements IAdvantage
{
    public static final DN = "Здоровье";
    public static final TYPE = TraitType.createType(DN, HealthAdvantage.new);

    private static final EXPR = new PBTrait(SizeAdvantage.DN).plus(new PBTrait(STAMINA.getDN()));

    @Serialize("bashing")
    private var bashing:Int = 0;

    @Serialize("lethal")
    private var lethal:Int = 0;

    @Serialize("aggravated")
    private var aggravated:Int = 0;

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type, EXPR);
        this.eventBus.addHandler(
            ActionBuildPoolEvent,
            this.applyHealthPenalty,
            HandlerPriority.NORMAL
        );
        this.eventBus.addHandler(
            GetHealthTraitEvent,
            this.setHealthTrait,
            HandlerPriority.NORMAL
        );
    }

    public function getBashing():Int
    {
        return this.bashing;
    }

    public function getLethal():Int
    {
        return this.lethal;
    }

    public function getAggravated():Int
    {
        return this.aggravated;
    }

    private function getFilledDamage():Int
    {
        return this.bashing + this.lethal + this.aggravated;
    }

    public function getHealthLeft():Int
    {
        return this.getValue() - this.getFilledDamage();
    }

    public function isDead():Bool
    {
        var healthValue = this.getValue();
        return this.aggravated >= healthValue;
    }

    private function applyDamage(damage:Damage):Void
    {
        var maxHealth = this.getValue();

        for (i in 0...damage.getBashing())
        {
            if (this.getFilledDamage() >= maxHealth)
            {
                if (this.bashing != 0)
                {
                    this.bashing--;
                    this.lethal++;
                } else if (this.lethal != 0)
                {
                    this.lethal--;
                    this.aggravated++;
                }
            } else
            {
                this.bashing++;
            }
        }

        for (i in 0...damage.getLethal())
        {
            if (this.getFilledDamage() >= maxHealth)
            {
                if (this.bashing != 0)
                {
                    this.bashing--;
                    this.lethal++;
                } else if (this.lethal != 0)
                {
                    this.lethal--;
                    this.aggravated++;
                }
            } else
            {
                this.lethal++;
            }
        }

        for (i in 0...damage.getAggravated())
        {
            if (this.getFilledDamage() >= maxHealth)
            {
                if (this.bashing != 0)
                {
                    this.bashing--;
                    this.aggravated++;
                } else if (this.lethal != 0)
                {
                    this.lethal--;
                    this.aggravated++;
                }
            } else
            {
                this.aggravated++;
            }
        }
    }

    public function dealDamage(damage:Damage):Void
    {
        this.applyDamage(damage);

        this.eventBus.post(
            new GameObjectDamagedEvent(this.gameObject, damage)
        );

        if (isDead())
        {
            this.eventBus.post(
                new GameObjectDiedEvent(this.gameObject)
            );
        }

        this.notifyUpdated();
    }

    private function setHealthTrait(event:GetHealthTraitEvent):Void
    {
        event.setHealthTrait(this);
    }

    private function applyHealthPenalty(event:ActionBuildPoolEvent):Void
    {
        if (!event.isPoolOwner(this.gameObject))
            return;

        // TODO: Ignore Stamina roll to avoid becoming unconscious
        var healthLeft = this.getHealthLeft();

        var penalty = 0;
        if (healthLeft == 3)
            penalty = -1;
        if (healthLeft == 2)
            penalty = -2;
        if (healthLeft <= 1)
            penalty = -3;

        event.getActionPool().getRequest().addModifier(penalty, HealthAdvantage.DN);
    }
}
