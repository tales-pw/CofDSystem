package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   Guard weapon tag.
 *
 *   @see <https://tales.pw/page/guard_(weapon_tag)>
**/
@RegisterTraitTypes
@:expose("GuardTag")
class GuardTag extends WeaponTag
{
    public static final DN = "guard_(weapon_tag)";
    public static final TYPE = cast TraitType.createType(DN, GuardTag.new);

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(ActionPoolEvent, this.applyBonus);
    }

    public function applyBonus(e:ActionPoolEvent):Void
    {
        var action = e.getAction();
        var pool = e.getActionPool();
        var request = pool.getRequest();

        if (!this.isHolderPool(pool))
            return;

        if (!this.isHolderDefence(action))
            return;

        request.addModifier(1, this.getDN());
    }
}
