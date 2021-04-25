package pw.tales.cofdsystem.character.traits.tilts;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.Trait;

class Tilt extends Trait {
    public function new(dn:String, gameObject:GameObject, type:TiltType) {
        super(dn, gameObject, type);
    }
}
