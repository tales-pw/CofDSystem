package pw.tales.cofdsystem.action_attack;

import pw.tales.cofdsystem.action.competition.Competition;
import pw.tales.cofdsystem.action.RollAction;
import pw.tales.cofdsystem.action.EnumTime;
import pw.tales.cofdsystem.action_attack.events.AttackDamageDealtEvent;
import pw.tales.cofdsystem.action_attack.events.AttackDamageGetEvent;
import pw.tales.cofdsystem.action_attack.events.AttackDamageGetTypeEvent;
import pw.tales.cofdsystem.action_attack.events.AttackHitEvent;
import pw.tales.cofdsystem.action_attack.events.AttackInitiatedEvent;
import pw.tales.cofdsystem.action_attack.events.AttackMissEvent;
import pw.tales.cofdsystem.action_attack.events.AttackSuccesesEvent;
import pw.tales.cofdsystem.damage.Damage;
import pw.tales.cofdsystem.damage.DamageType;
import pw.tales.cofdsystem.game_object.health_helper.HealthTraitHelper;

class AttackAction extends RollAction
{
    private final competition:Competition;

    private var damage:Null<Damage> = null;

    public function new(competition:Competition, system:CofDSystem)
    {
        super(competition, EnumTime.INSTANT, system);
        this.competition = competition;
    }

    public function getCompetition():Competition
    {
        return this.competition;
    }

    public function getDamage():Damage
    {
        if (this.damage == null)
            throw "Asked for damage too early";
        return this.damage;
    }

    private function createDamageType(value:Int, damageType:DamageType):Damage
    {
        if (damageType == DamageType.AGGRAVATED)
            return new Damage(0, 0, value);

        if (damageType == DamageType.LETHAL)
            return new Damage(0, value, 0);

        return new Damage(value, 0, 0);
    }

    private override function beforeAction():Void
    {
        super.beforeAction();
        system.events.post(new AttackInitiatedEvent(this));
    }

    private override function perform():Void
    {
        var actorPool = this.competition.getActorPool();
        var targetPool = this.competition.getTargetPool();

        var target = targetPool.getGameObject();

        if (this.competition.getWinnerPool() == actorPool)
        {
            system.events.post(new AttackHitEvent(this));

            var successes = actorPool.getResponse().getSuccesses();
            if (this.competition.willRoll(targetPool))
            {
                successes -= targetPool.getResponse().getSuccesses();
            }
            var damageType = DamageType.BASHING;

            // Post damage type event
            var eventDamageType = new AttackDamageGetTypeEvent(damageType, this);
            system.events.post(eventDamageType);
            damageType = eventDamageType.getDamageType();

            // Allow weapon to modifiy damage successes while leaving response object alone
            var eventAttackSuccess = new AttackSuccesesEvent(successes, this);
            system.events.post(eventAttackSuccess);
            successes = eventAttackSuccess.getDamageSucceses();

            // Create damage object
            this.damage = this.createDamageType(successes, damageType);

            // Post damage event
            var eventDamage = new AttackDamageGetEvent(damage, this);
            system.events.post(eventDamage);
            this.damage = eventDamage.getDamage();

            // Submit damage to gameObject
            HealthTraitHelper.get(target).dealDamage(this.damage);

            // Post final damage event
            system.events.post(new AttackDamageDealtEvent(this.damage, this));
        } else
        {
            system.events.post(new AttackMissEvent(this));
        }
    }
}
