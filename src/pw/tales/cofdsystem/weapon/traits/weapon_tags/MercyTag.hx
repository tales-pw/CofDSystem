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
@:expose("MercyTag")
class MercyTag extends WeaponTag
{
    public static final DN = "mercy_(weapon_tag)";
    public static final TYPE = cast TraitType.createType(DN, MercyTag.new);

    public static final PRIORITY = HandlerPriority.lower([WeaponTrait.PRIORITY]);

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(
            AttackDamageGetTypeEvent,
            this.makeBashing,
            PRIORITY
        );
    }

    private function makeBashing(e:AttackDamageGetTypeEvent):Void
    {
        var action = e.getAction();

        // Is this holder's attack action.
        if (!this.isHolderAttack(action))
            return;

        e.setDamageType(DamageType.BASHING);
    }
}
