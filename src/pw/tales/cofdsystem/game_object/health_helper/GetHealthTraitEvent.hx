package pw.tales.cofdsystem.game_object.health_helper;

import pw.tales.cofdsystem.game_object.events.GameObjectEvent;

@:expose("GetHealthTraitEvent")
class GetHealthTraitEvent extends GameObjectEvent
{
    private var trait:Null<IHealthTrait> = null;

    public function setHealthTrait(trait:IHealthTrait):Void
    {
        this.trait = trait;
    }

    public function getHealthTrait():Null<IHealthTrait>
    {
        return this.trait;
    }
}
