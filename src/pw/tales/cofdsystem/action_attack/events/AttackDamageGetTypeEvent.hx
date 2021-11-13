package pw.tales.cofdsystem.action_attack.events;

import pw.tales.cofdsystem.damage.DamageType;

/**
 * Event used to change type of damage dealt by attack.
**/
@:expose("AttackDamageGetTypeEvent")
class AttackDamageGetTypeEvent extends AttackEvent
{
    private var damageType:DamageType;

    public function new(damageType:DamageType, action:AttackAction)
    {
        super(action);
        this.damageType = damageType;
    }

    public function getDamageType():DamageType
    {
        return this.damageType;
    }

    public function setDamageType(damage:DamageType)
    {
        this.damageType = damage;
    }
}
