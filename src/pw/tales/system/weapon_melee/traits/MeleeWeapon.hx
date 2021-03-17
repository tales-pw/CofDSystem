package pw.tales.system.weapon_melee.traits;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action.events.pool.ActionPoolEvent;
import pw.tales.system.action_attack.AttackAction;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.character.traits.skill.Skills;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.weapon.traits.WeaponTrait;
import pw.tales.system.weapon.Weapon;

class MeleeWeapon extends WeaponTrait {
    public static final DN = "melee_weapon";
    public static final TYPE = TraitType.createType(DN, create);

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

        event.getActionPool().getRequest().setTraits([Attributes.STRENGTH.getDN(), Skills.WEAPONRY.getDN()]);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<MeleeWeapon>):MeleeWeapon {
        return new MeleeWeapon(gameObject);
    }
}
