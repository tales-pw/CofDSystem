package pw.tales.cofdsystem.game_object.events;

import pw.tales.cofdsystem.game_object.traits.Trait;

@:expose("TraitModEvent")
class TraitModEvent extends GameObjectEvent
{
    private var finalModifier:Int = 0;
    private final trait:Trait;

    public function new(gameObject:GameObject, trait:Trait)
    {
        super(gameObject);
        this.trait = trait;
    }

    public function getTrait():Trait
    {
        return this.trait;
    }

    public function apply(modifier:Int):Void
    {
        finalModifier = finalModifier + modifier;
    }

    public function getModifier():Int
    {
        return this.finalModifier;
    }
}
