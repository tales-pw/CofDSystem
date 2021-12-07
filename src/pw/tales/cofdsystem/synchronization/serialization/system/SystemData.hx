package pw.tales.cofdsystem.synchronization.serialization.system;

import pw.tales.cofdsystem.synchronization.serialization.system.parts.TagSerialization.ApiWeaponTag;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.ArmorSerialization.ApiArmor;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.RangedSerialization.ApiRangedWeapon;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.MeleeSerialization.ApiMeleeWeapon;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.AbilitySerialization.ApiAbility;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.TiltSerialization.ApiTilt;
import pw.tales.cofdsystem.synchronization.serialization.system.parts.ConditionSerialization.ApiCondition;

typedef SystemData = {
    version:String,
    conditions:Array<ApiCondition>,
    tilts:Array<ApiTilt>,
    abilities:Array<ApiAbility>,
    melee_weapons:Array<ApiMeleeWeapon>,
    ranged_weapons:Array<ApiRangedWeapon>,
    armor:Array<ApiArmor>,
    weapon_tags:Array<ApiWeaponTag>
}
