package pw.tales.system.character.traits.aspiration;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

class AspirationType extends TraitType<Aspiration> {
    override public function isMultiInstanced():Bool {
        return true;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):Aspiration {
        return new Aspiration(dn, gameObject, this);
    }
}
