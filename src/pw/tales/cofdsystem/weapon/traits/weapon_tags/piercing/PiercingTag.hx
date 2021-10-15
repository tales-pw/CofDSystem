package pw.tales.cofdsystem.weapon.traits.weapon_tags.piercing;

import pw.tales.cofdsystem.armor.traits.armor_rating.events.AttackArmorGetEvent;
import pw.tales.cofdsystem.game_object.GameObject;

/**
 *   Piercing weapon tag.
 *
 *   @see <https://tales.pw/page/piercing_(weapon_tag)>
**/
class PiercingTag extends WeaponTag
{
    private final piercingType:PiercingTagType;

    public function new(gameObject:GameObject, type:PiercingTagType)
    {
        super(type.getDN(), gameObject, type);
        this.piercingType = type;
        this.holderEventBus.addHandler(AttackArmorGetEvent, this.applyPiercing);
    }

    public function applyPiercing(event:AttackArmorGetEvent):Void
    {
        var action = event.getAction();

        // Is this holder's attack action.
        if (!this.isHolderAttack(action))
            return;

        var general = event.getGeneral();
        var ballistic = event.getBallistic();
        var piercing = this.piercingType.getLevel();

        ballistic = ballistic - piercing;
        if (ballistic < 0)
        {
            piercing = ballistic;
            ballistic = 0;
        } else
        {
            piercing = piercing - event.getBallistic();
        }

        piercing = Std.int(Math.abs(piercing));

        general = general - piercing;
        if (general < 0)
            general = 0;

        event.setGeneral(general);
        event.setBallistic(ballistic);
    }
}
