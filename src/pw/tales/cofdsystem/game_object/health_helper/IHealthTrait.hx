package pw.tales.cofdsystem.game_object.health_helper;

import pw.tales.cofdsystem.damage.Damage;

interface IHealthTrait
{
    public function dealDamage(damage:Damage):Void;
}
