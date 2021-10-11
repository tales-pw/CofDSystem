package pw.tales.cofdsystem.weapon.traits.weapon_tags.piercing;

import pw.tales.cofdsystem.action_attack.AttackAction;
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

    public function applyPiercing(e:AttackArmorGetEvent)
    {
        var action = e.getAction();

        if (!Std.isOfType(action, AttackAction))
            return;
        if (!this.isHolderActor(action))
            return;
        if (!this.isActionWithWeapon(action))
            return;

        var general = e.getGeneral();
        var ballistic = e.getBallistic();
        var piercing = this.piercingType.getLevel();

        ballistic = ballistic - piercing;
        if (ballistic < 0)
        {
            piercing = Std.int(Math.abs(ballistic));
            ballistic = 0;
        } else
        {
            piercing = piercing - e.getBallistic();
        }

        general = general - piercing;
        if (general < 0)
            general = 0;

        e.setGeneral(general);
        e.setBallistic(ballistic);
    }
}
