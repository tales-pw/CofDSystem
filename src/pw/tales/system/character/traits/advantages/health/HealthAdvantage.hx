package pw.tales.system.character.traits.advantages.health;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.character.traits.advantages.health.events.GameObjectDamagedEvent;
import pw.tales.system.character.traits.advantages.health.events.GameObjectDiedEvent;
import pw.tales.system.character.traits.advantages.SizeAdvantage;
import pw.tales.system.character.traits.attribute.Attributes.*;
import pw.tales.system.damage.Damage;
import pw.tales.system.dices.pool.builder.PBTrait;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.health_helper.GetHealthTraitEvent;
import pw.tales.system.game_object.health_helper.IHealthTrait;
import pw.tales.system.game_object.traits.advantages.AdvantageExpression;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.events.HandlerPriority;

@RegisterTraitTypes
@:expose("HealthAdvantage")
class HealthAdvantage extends AdvantageExpression implements IHealthTrait {
    public static final DN = "Здоровье";
    public static final TYPE:TraitType<HealthAdvantage> = cast TraitType.createType(DN, create);

    private static final EXPR = new PBTrait(SizeAdvantage.DN).plus(new PBTrait(STAMINA.getDN()));

    @Serialize("bashing")
    private var bashing:Int = 0;

    @Serialize("lethal")
    private var lethal:Int = 0;

    @Serialize("aggravated")
    private var aggravated:Int = 0;

    public function new(gameObject:GameObject) {
        super(gameObject, TYPE, EXPR);
        this.eventBus.addHandler(ActionBuildPoolEvent, this.applyHealthPenalty, HandlerPriority.NORMAL);
        this.eventBus.addHandler(GetHealthTraitEvent, this.setHealthTrait, HandlerPriority.NORMAL);
    }

    public function getBashing():Int {
        return this.bashing;
    }

    public function getLethal():Int {
        return this.lethal;
    }

    public function getAggravated():Int {
        return this.aggravated;
    }

    private function getFilledDamage():Int {
        return this.bashing + this.lethal + this.aggravated;
    }

    public function getHealthLeft():Int {
        return this.getValue() - this.getFilledDamage();
    }

    public function isDead() {
        var healthValue = this.getValue();
        return this.aggravated >= healthValue;
    }

    private function applyDamage(damage:Damage) {
        var maxHealth = this.getValue();

        for (i in 0...damage.getBashing()) {
            if (this.getFilledDamage() >= maxHealth) {
                if (this.bashing != 0) {
                    this.bashing--;
                    this.lethal++;
                } else if (this.lethal != 0) {
                    this.lethal--;
                    this.aggravated++;
                }
            } else {
                this.bashing++;
            }
        }

        for (i in 0...damage.getLethal()) {
            if (this.getFilledDamage() >= maxHealth) {
                if (this.bashing != 0) {
                    this.bashing--;
                    this.lethal++;
                } else if (this.lethal != 0) {
                    this.lethal--;
                    this.aggravated++;
                }
            } else {
                this.lethal++;
            }
        }

        for (i in 0...damage.getAggravated()) {
            if (this.getFilledDamage() >= maxHealth) {
                if (this.bashing != 0) {
                    this.bashing--;
                    this.aggravated++;
                } else if (this.lethal != 0) {
                    this.lethal--;
                    this.aggravated++;
                }
            } else {
                this.aggravated++;
            }
        }
    }

    public function dealDamage(damage:Damage):Void {
        this.applyDamage(damage);

        this.eventBus.post(new GameObjectDamagedEvent(this.gameObject, damage));
        if (isDead()) this.eventBus.post(new GameObjectDiedEvent(this.gameObject));

        this.notifyUpdated();
    }

    private function setHealthTrait(event:GetHealthTraitEvent) {
        event.setHealthTrait(this);
    }

    private function applyHealthPenalty(event:ActionBuildPoolEvent) {
        if (!event.isPoolOwner(this.gameObject)) return;

        // TODO: Ignore Stamina roll to avoid becoming unconscious
        var healthLeft = this.getHealthLeft();

        var penalty = 0;
        if (healthLeft == 3) penalty = -1;
        if (healthLeft == 2) penalty = -2;
        if (healthLeft <= 1) penalty = -3;

        event.getActionPool().getRequest().addModifier(penalty, HealthAdvantage.DN);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<HealthAdvantage>):HealthAdvantage {
        return new HealthAdvantage(gameObject);
    }
}