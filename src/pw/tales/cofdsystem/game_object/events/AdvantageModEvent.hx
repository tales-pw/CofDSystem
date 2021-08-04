package pw.tales.cofdsystem.game_object.events;

import pw.tales.cofdsystem.game_object.traits.advantages.Advantage;

class AdvantageModEvent extends GameObjectEvent
{
    private var finalModifier:Int = 0;
    private final advantage:Advantage;

    public function new(gameObject:GameObject, advantage:Advantage)
    {
        super(gameObject);
        this.advantage = advantage;
    }

    public function getAdvantage():Advantage
    {
        return this.advantage;
    }

    public function apply(modifier:Int)
    {
        finalModifier = finalModifier + modifier;
    }

    public function getModifier():Int
    {
        return this.finalModifier;
    }
}
