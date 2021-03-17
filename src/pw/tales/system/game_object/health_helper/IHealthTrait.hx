package pw.tales.system.game_object.health_helper;

import pw.tales.system.damage.Damage;

interface IHealthTrait {
    public function dealDamage(damage:Damage):Void;
}
