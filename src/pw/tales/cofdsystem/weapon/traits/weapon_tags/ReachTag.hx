package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   Reach weapon tag.
 *
 *   @see <https://tales.pw/page/reach_(weapon_tag)>
**/
@RegisterTraitTypes
@:expose("ReachTag")
class ReachTag extends WeaponTag
{
    public static final DN = "reach_(weapon_tag)";
    public static final TYPE = cast TraitType.createType(DN, ReachTag.new);

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(ActionPoolEvent, this.applyBonuses);
    }

    public function checkTargetHasReach(attack:AttackAction):Bool
    {
        var attacker = attack.getCompetition().getActor();
        var heldWeapon = attacker.getTrait(HeldWeapon.TYPE);

        var main = heldWeapon.getMainHand();
        var off = heldWeapon.getOffHand();

        var tags = [];

        if (main != null)
        {
            tags = tags.concat(main.getWeaponTags());
        }

        if (off != null)
        {
            tags = tags.concat(off.getWeaponTags());
        }

        return tags.contains(ReachTag.TYPE);
    }

    public function applyBonuses(e:ActionPoolEvent):Void
    {
        var action = e.getAction();
        var pool = e.getActionPool();

        // Is this holder's pool event.
        if (!this.isHolderPool(pool))
            return;

        // Is this is attack with holder defence.
        if (!this.isHolderDefence(action))
            return;

        var attack:AttackAction = cast Utility.downcast(action, AttackAction);

        // Only apply bonus if enemy doesn't have weapon with reach.
        if (this.checkTargetHasReach(attack))
            return;

        pool.getRequest().addModifier(1, DN);
    }
}
