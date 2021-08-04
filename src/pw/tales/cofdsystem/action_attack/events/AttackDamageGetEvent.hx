package pw.tales.cofdsystem.action_attack.events;

import pw.tales.cofdsystem.damage.Damage;

/**
 * Event used to change damage dealt by attack. Including armor absorption.
**/
class AttackDamageGetEvent extends AttackDamageEvent
{
    public function setDamage(damage:Damage)
    {
        this.damage = damage;
    }
}
