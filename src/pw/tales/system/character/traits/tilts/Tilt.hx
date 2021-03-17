package pw.tales.system.character.traits.tilts;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.Trait;

class Tilt extends Trait {
    public function new(dn:String, gameObject:GameObject, type:TiltType) {
        super(dn, gameObject, type);
    }
}
