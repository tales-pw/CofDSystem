package pw.tales.cofdsystem.game_object.events.traits;

import pw.tales.cofdsystem.game_object.traits.Trait;

@:expose("TraitEvent")
class TraitEvent extends GameObjectEvent
{
    private var trait:Trait;

    public function new(trait:Trait)
    {
        super(trait.getGameObject());
        this.trait = trait;
    }

    public function getTrait():Trait
    {
        return this.trait;
    }
}
