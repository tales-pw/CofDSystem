package pw.tales.cofdsystem.game_object.health_helper;

import pw.tales.cofdsystem.game_object.events.GameObjectEvent;

class GetHealthTraitEvent extends GameObjectEvent
{
    private var trait:Null<IHealthTrait> = null;

    public function setHealthTrait(trait:IHealthTrait)
    {
        this.trait = trait;
    }

    public function getHealthTrait():Null<IHealthTrait>
    {
        return this.trait;
    }
}
