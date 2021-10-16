package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   Accurate weapon tag.
 *   
 *   @see <https://tales.pw/page/accurate_(weapon_tag)>
**/
@RegisterTraitTypes
class AccurateTag extends WeaponTag
{
    public static final DN = "accurate_(weapon_tag)";
    public static final TYPE = cast TraitType.createType(DN, AccurateTag.new);

    public function new(dn:String, gameObject:GameObject, type:TraitType<AccurateTag>)
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(ActionBuildPoolEvent, this.applyBonus);
    }

    public function applyBonus(e:ActionBuildPoolEvent):Void
    {
        var action = e.getAction();
        var pool = e.getActionPool();

        // Is this holder's pool event.
        if (!this.isHolderPool(pool))
            return;

        // Is this holder's attack action.
        if (!this.isHolderAttack(action))
            return;

        pool.getRequest().addModifier(1, DN);
    }
}
