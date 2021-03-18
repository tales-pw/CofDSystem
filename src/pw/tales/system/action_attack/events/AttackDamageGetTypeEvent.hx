package pw.tales.system.action_attack.events;

import pw.tales.system.damage.DamageType;

/**
* Event used to change type of damage dealt by attack.
**/
class AttackDamageGetTypeEvent extends AttackEvent {
    private var damageType:DamageType;

    public function new(damageType:DamageType, action:AttackAction) {
        super(action);
        this.damageType = damageType;
    }

    public function getDamageType():DamageType {
        return this.damageType;
    }

    public function setDamageType(damage:DamageType) {
        this.damageType = damage;
    }
}
