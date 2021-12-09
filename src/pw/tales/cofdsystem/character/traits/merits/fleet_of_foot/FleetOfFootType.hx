package pw.tales.cofdsystem.character.traits.merits.fleet_of_foot;

import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.character.traits.merits.MeritType;

@:expose("FleetOfFootType")
class FleetOfFootType extends MeritType
{
    override public function isMultiInstanced():Bool
    {
        return false;
    }

    override public dynamic function createWithDN(dn:String, gameObject:GameObject):Merit
    {
        return new FleetOfFootMerit(dn, gameObject, this);
    }
}
