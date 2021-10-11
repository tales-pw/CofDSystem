package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.game_object.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   Concealed weapon tag.
 *
 *   @see <https://tales.pw/page/concealed_(weapon_tag)>
**/
@RegisterTraitTypes
class ConcealedTag extends WeaponTag
{
    public static final DN = "concealed_(weapon_tag)";
    public static final TYPE:TraitType<ConcealedTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
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

        if (!Std.isOfType(action, AttackAction))
            return;

        if (!this.isHolderPool(pool))
            return;

        if (!pool.hasTrait(DefenceAdvantage.TYPE.getDN()))
            return;

        var value = this.getShieldMod();

        // Check if other shield is better
        if (this.isOtherShieldBetter(value))
            return;

        request.addModifier(value, this.getDN());
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<ConcealedTag>):ConcealedTag
    {
        return new ConcealedTag(gameObject);
    }
}
