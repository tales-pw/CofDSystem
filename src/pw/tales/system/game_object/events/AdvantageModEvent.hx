package pw.tales.system.game_object.events;

import pw.tales.system.game_object.events.IGameObjectEvent;
import pw.tales.system.game_object.traits.advantages.Advantage;

class AdvantageModEvent implements IGameObjectEvent {
    private var finalModifier:Int = 0;

    private final gameObject:GameObject;
    private final advantage:Advantage;

    public function new(gameObject:GameObject, advantage:Advantage) {
        this.gameObject = gameObject;
        this.advantage = advantage;
    }

    public function getCharacter():GameObject {
        return this.gameObject;
    }

    public function getAdvantage():Advantage {
        return this.advantage;
    }

    public function apply(modifier:Int) {
        finalModifier = finalModifier + modifier;
    }

    public function getModifier():Int {
        return this.finalModifier;
    }

    public function isRelated(character:GameObject):Bool {
        return this.gameObject == gameObject;
    }
}