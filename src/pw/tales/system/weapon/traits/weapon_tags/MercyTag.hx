package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.action_attack.AttackAction;
import pw.tales.system.action_attack.events.AttackDamageGetTypeEvent;
import pw.tales.system.damage.DamageType;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.events.HandlerPriority;

/**
 *   Mercy weapon tag.
 *
 *   @see <https://tales.pw/page/mercy_(weapon_tag)>
**/
class MercyTag extends WeaponTag {
    public static final DN = "mercy_(weapon_tag)";
    public static final TYPE = TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(
            AttackDamageGetTypeEvent,
            this.makeBashing,
            HandlerPriority.after([Weapon.ATTACK_POOL_PRIORITY])
        );
    }

    private function makeBashing(e:AttackDamageGetTypeEvent) {
        var action = e.getAction();

        if (!Std.isOfType(action, AttackAction)) return;
        if (!this.doesHolderAct(action)) return;
        if (!this.isActionWithWeapon(action)) return;

        e.setDamageType(DamageType.BASHING);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<MercyTag>):MercyTag {
        return new MercyTag(gameObject);
    }
}
