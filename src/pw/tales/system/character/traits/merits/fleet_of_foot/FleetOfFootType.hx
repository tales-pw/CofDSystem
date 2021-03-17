package pw.tales.system.character.traits.merits.fleet_of_foot;

import pw.tales.system.game_object.GameObject;
import pw.tales.system.character.traits.merits.MeritType;

class FleetOfFootType extends MeritType {
    override public function isMultiInstanced():Bool {
        return false;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):FleetOfFootMerit {
        return new FleetOfFootMerit(this.getDN(), gameObject);
    }
}
