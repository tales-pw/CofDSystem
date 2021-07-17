package pw.tales.cofdsystem.character.traits.tilts;

import pw.tales.cofdsystem.utils.events.HandlerPriority;
import pw.tales.cofdsystem.scene.events.SceneEndEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;

class Tilt extends Trait {
    public function new(dn:String, gameObject:GameObject, type:TiltType) {
        super(dn, gameObject, type);
        this.eventBus.addHandler(
            SceneEndEvent,
            this.applyInitiativeMod,
            HandlerPriority.NORMAL
        );
    }

    private function applyInitiativeMod(event:SceneEndEvent) {
        this.gameObject.getTraitManager().removeTrait(this);
    }
}
