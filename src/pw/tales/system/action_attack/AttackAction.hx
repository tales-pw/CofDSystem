package pw.tales.system.action_attack;

import pw.tales.system.action.Action;
import pw.tales.system.action.EnumTime;
import pw.tales.system.action.opposition.base.OppositionCompetitive;
import pw.tales.system.action_attack.events.AttackDamageDealtEvent;
import pw.tales.system.action_attack.events.AttackDamageGetEvent;
import pw.tales.system.action_attack.events.AttackDamageGetTypeEvent;
import pw.tales.system.action_attack.events.AttackHitEvent;
import pw.tales.system.action_attack.events.AttackInitiatedEvent;
import pw.tales.system.action_attack.events.AttackMissEvent;
import pw.tales.system.action_attack.events.AttackSuccesesEvent;
import pw.tales.system.damage.Damage;
import pw.tales.system.damage.DamageType;
import pw.tales.system.game_object.health_helper.HealthTraitHelper;

class AttackAction extends Action {
    private final competitiveOpposition:OppositionCompetitive;
    private var damage:Null<Damage> = null;

    public function new(opposition:OppositionCompetitive, system:CofDSystem) {
        super(opposition, EnumTime.INSTANT, system);
        this.competitiveOpposition = opposition;
    }

    public function getCompetitiveOpposition():OppositionCompetitive {
        return this.competitiveOpposition;
    }

    override public function getOpposition():OppositionCompetitive {
        return this.competitiveOpposition;
    }

    public function getDamage():Damage {
        if (this.damage == null) throw "Asked for damage too early";
        return this.damage;
    }

    private function createDamageType(value:Int, damageType:DamageType) {
        if (damageType == DamageType.AGGRAVATED) return new Damage(0, 0, value);

        if (damageType == DamageType.LETHAL) return new Damage(0, value, 0);

        return new Damage(value, 0, 0);
    }

    private override function beforeAction() {
        super.beforeAction();
        system.events.post(new AttackInitiatedEvent(this, system));
    }

    private override function perform() {
        var opposition = this.getOpposition();
        var actor = opposition.getActorPool().getGameObject();
        var target = opposition.getTargetPool().getGameObject();

        if (opposition.getWinnerPool() == opposition.getActorPool()) {
            system.events.post(new AttackHitEvent(this, system));

            var successes = opposition.getActorPool().getResponse().getSuccesses();
            if (opposition.getTargetPool().getResponse() != null) {
                successes -= opposition.getTargetPool().getResponse().getSuccesses();
            }
            var damageType = DamageType.BASHING;

            // Post damage type event
            var eventDamageType = new AttackDamageGetTypeEvent(damageType, this, system);
            system.events.post(eventDamageType);
            damageType = eventDamageType.getDamageType();

            // Allow weapon to modifiy damage successes while leaving response object alone
            var eventAttackSuccess = new AttackSuccesesEvent(successes, this, system);
            system.events.post(eventAttackSuccess);
            successes = eventAttackSuccess.getDamageSucceses();

            // Create damage object
            this.damage = this.createDamageType(successes, damageType);

            // Post damage event
            var eventDamage = new AttackDamageGetEvent(damage, this, system);
            system.events.post(eventDamage);
            this.damage = eventDamage.getDamage();

            // Submit damage to gameObject
            HealthTraitHelper.get(target).dealDamage(this.damage);

            // Post final damage event
            system.events.post(new AttackDamageDealtEvent(this.damage, this, system));
        } else {
            system.events.post(new AttackMissEvent(this, system));
        }
    }
}
