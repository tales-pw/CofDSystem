package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.action_attack.events.AttackDamageGetTypeEvent;
import pw.tales.cofdsystem.damage.DamageType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.events.HandlerPriority;

/**
 *   Mercy weapon tag.
 *
 *   @see <https://tales.pw/page/mercy_(weapon_tag)>
**/
@RegisterTraitTypes
class MercyTag extends WeaponTag
{
    public static final DN = "mercy_(weapon_tag)";
    public static final TYPE:TraitType<MercyTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(AttackDamageGetTypeEvent, this.makeBashing, HandlerPriority.after([Weapon.ATTACK_POOL_PRIORITY]));
    }

    private function makeBashing(e:AttackDamageGetTypeEvent):Void
    {
        var action = e.getAction();

        // Is this holder's attack action.
        if (!this.isHolderAttack(action))
            return;

        e.setDamageType(DamageType.BASHING);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<MercyTag>):MercyTag
    {
        return new MercyTag(gameObject);
    }
}
