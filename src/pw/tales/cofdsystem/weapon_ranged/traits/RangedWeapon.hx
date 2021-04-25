package pw.tales.cofdsystem.weapon_ranged.traits;

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
class RangedWeapon extends WeaponTrait {
    public static final DN = "ranged_weapon";
    public static final TYPE:TraitType<RangedWeapon> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionBuildPoolEvent, this.changeTraits, Weapon.ATTACK_POOL_PRIORITY);
    }

    public function changeTraits(event:ActionPoolEvent) {
        var action = event.getAction();
        var opposition = action.getOpposition();

        if (!Std.isOfType(action, AttackAction)) return;
        if (!this.doesHolderAct(action)) return;
        if (!this.isActionWithWeapon(action)) return;

        event.getActionPool().getRequest().setTraits([Attributes.DEXTERITY.getDN(), Skills.SHOOTING.getDN()]);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<RangedWeapon>):RangedWeapon {
        return new RangedWeapon(gameObject);
    }
}
