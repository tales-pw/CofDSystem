package pw.tales.cofdsystem.game_object.health_helper;

@:expose("HealthTraitHelper")
class HealthTraitHelper
{
    public static function get(gameObject:GameObject):IHealthTrait
    {
        var event = new GetHealthTraitEvent(gameObject);
        gameObject.getEventBus().post(event);

        var healthTrait = event.getHealthTrait();
        if (healthTrait == null)
            throw new NoHealthTraitException(gameObject);

        return healthTrait;
    }
}
