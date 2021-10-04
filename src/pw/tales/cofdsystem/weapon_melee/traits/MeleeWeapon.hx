package pw.tales.cofdsystem.weapon_melee.traits;

import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.traits.WeaponTrait;
import pw.tales.cofdsystem.weapon.Weapon;

@RegisterTraitTypes
class MeleeWeapon extends WeaponTrait
{
    public static final DN = "melee_weapon";
    public static final TYPE:TraitType<MeleeWeapon> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionBuildPoolEvent, this.changeTraits, Weapon.ATTACK_POOL_PRIORITY);
    }

    public function changeTraits(event:ActionPoolEvent):Void
    {
        var action = Utility.downcast(event.getAction(), AttackAction);

        if (action == null)
        {
            return;
        }

        if (!this.doesHolderAct(action))
            return;

        if (!this.isActionWithWeapon(action))
            return;

        event.getActionPool().getRequest().setTraits([Attributes.STRENGTH.getDN(), Skills.WEAPONRY.getDN()]);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<MeleeWeapon>):MeleeWeapon
    {
        return new MeleeWeapon(gameObject);
    }
}
