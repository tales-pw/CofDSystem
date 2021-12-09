package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.common.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   Concealed weapon tag.
 *
 *   @see <https://tales.pw/page/concealed_(weapon_tag)>
**/
@RegisterTraitTypes
@:expose("ConcealedTag")
class ConcealedTag extends WeaponTag
{
    public static final DN = "concealed_(weapon_tag)";
    public static final TYPE = cast TraitType.createType(DN, ConcealedTag.new);

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(ActionPoolEvent, this.applyBonus);
    }

    /**
        Get shield defence bonus based on its size.
    **/
    private function getShieldMod():Int
    {
        var size = this.gameObject.getTrait(SizeAdvantage.TYPE);

        if (size == null)
        {
            return 0;
        }

        return size.getValue();
    }

    /**
        Get if has another better shield in use.
    **/
    private function isOtherShieldBetter(value:Int):Bool
    {
        // TODO: implement
        return false;
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

        var value = this.getShieldMod();

        // Check if other shield is better
        if (this.isOtherShieldBetter(value))
            return;

        request.addModifier(value, this.getDN());
    }
}
