package pw.tales.cofdsystem.scene.initiative.events;

import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;
import pw.tales.cofdsystem.game_object.GameObject;

class InitiativeModifiersEvent extends InitiativeEvent implements IGameObjectEvent {
    private final gameObject:GameObject;

    private var finalModifier:Int = 0;

    public function new(gameObject:GameObject, initiative:Initiative) {
        super(initiative);
        this.gameObject = gameObject;
    }

    public function getGameObject():GameObject {
        return this.gameObject;
    }

    public function apply(modifier:Int) {
        finalModifier = finalModifier + modifier;
    }

    public function getModifier():Int {
        return this.finalModifier;
    }

    public function isRelated(gameObject:GameObject):Bool {
        return this.gameObject == gameObject;
    }
}
