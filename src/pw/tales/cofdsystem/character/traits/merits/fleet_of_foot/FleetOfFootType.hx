package pw.tales.cofdsystem.character.traits.merits.fleet_of_foot;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.merits.MeritType;

class FleetOfFootType extends MeritType {
    override public function isMultiInstanced():Bool {
        return false;
    }

    override public function createWithDN(dn:String, gameObject:GameObject):FleetOfFootMerit {
        return new FleetOfFootMerit(this.getDN(), gameObject);
    }
}
