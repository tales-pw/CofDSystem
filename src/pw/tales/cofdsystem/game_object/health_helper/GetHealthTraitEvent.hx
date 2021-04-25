package pw.tales.cofdsystem.game_object.health_helper;

import pw.tales.cofdsystem.game_object.events.IGameObjectEvent;

class GetHealthTraitEvent implements IGameObjectEvent {
    private final character:GameObject;
    private var trait:Null<IHealthTrait> = null;

    public function new(character:GameObject) {
        this.character = character;
    }

    public function setHealthTrait(trait:IHealthTrait) {
        this.trait = trait;
    }

    public function getHealthTrait():Null<IHealthTrait> {
        return this.trait;
    }

    public function isRelated(character:GameObject):Bool {
        return character == this.character;
    }
}
