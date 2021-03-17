package pw.tales.system.game_object.health_helper;

import pw.tales.system.game_object.health_helper.GetHealthTraitEvent;

class HealthTraitHelper {
    public static function get(gameObject:GameObject):IHealthTrait {
        var event = new GetHealthTraitEvent(gameObject);
        gameObject.getEventBus().post(event);

        var healthTrait = event.getHealthTrait();
        if (healthTrait == null) throw new NoHealthTraitException();

        return healthTrait;
    }
}
