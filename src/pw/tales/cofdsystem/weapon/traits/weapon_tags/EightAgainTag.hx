package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.weapon.traits.weapon_tags.base.ExplodeTag;
import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   8-Again weapon tag.
 *
 *   @see <https://tales.pw/page/8-again_(weapon_tag)>
**/
@RegisterTraitTypes
class EightAgainTag extends ExplodeTag
{
    public static final DN = "8-again_(weapon_tag)";
    public static final TYPE:TraitType<EightAgainTag> = cast TraitType.createType(DN, create);

    public override function getExplode():EnumExplode
    {
        return EnumExplode.EIGHT_AGAIN;
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<EightAgainTag>):EightAgainTag
    {
        return new EightAgainTag(dn, gameObject, t);
    }
}
