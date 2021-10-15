package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.equipment.events.StrengthReqEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   Two-handed weapon tag.
 *
 *   @see <https://tales.pw/page/two-handed_(weapon_tag)>
**/
@RegisterTraitTypes
class TwoHandedTag extends WeaponTag
{
    public static final DN = "two-handed_(weapon_tag)";
    public static final TYPE:TraitType<TwoHandedTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.eventBus.addHandler(StrengthReqEvent, this.increaseStrengthReq);
    }

    private function checkBothHandOccupied():Bool
    {
        var holder = this.getHolder();

        if (holder == null) {
            return false;
        }

        var heldWeapon = holder.getTrait(HeldWeapon.TYPE);

        if (heldWeapon == null)
        {
            return false;
        }

        return heldWeapon.getMainHand() != null && heldWeapon.getOffHand() != null;
    }

    private function increaseStrengthReq(e:StrengthReqEvent):Void
    {
        if (!this.checkBothHandOccupied())
        {
            return;
        }

        var value = e.getValue();
        e.setValue(value + 1);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<TwoHandedTag>):TwoHandedTag
    {
        return new TwoHandedTag(gameObject);
    }
}
