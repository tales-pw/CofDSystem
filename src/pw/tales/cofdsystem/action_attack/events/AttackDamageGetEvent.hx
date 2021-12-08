package pw.tales.cofdsystem.action_attack.events;

import pw.tales.cofdsystem.damage.Damage;

/**
 * Event used to change damage dealt by attack. Including armor absorption.
**/
@:expose("AttackDamageGetEvent")
class AttackDamageGetEvent extends AttackDamageEvent
{
    public function setDamage(damage:Damage):Void
    {
        this.damage = damage;
    }
}
