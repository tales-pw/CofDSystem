package pw.tales.system.action_attack.events;

import pw.tales.system.damage.Damage;

class AttackDamageEvent extends AttackEvent {
    private var damage:Damage;

    public function new(damage:Damage, action:AttackAction) {
        super(action);
        this.damage = damage;
    }

    public function getDamage():Damage {
        return this.damage;
    }
}
