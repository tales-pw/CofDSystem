package pw.tales.cofdsystem.serialization.system.serializers;

import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.serialization.system.SystemData;
import pw.tales.cofdsystem.weapon.traits.weapon_tags.WeaponTag;

class WeaponTagSerializer extends SimpleDataSerializer
{
    public override function create(data:SimpleData):TraitType<Dynamic>
    {
        return TraitType.createType(data.dn, WeaponTag.create);
    }
}
