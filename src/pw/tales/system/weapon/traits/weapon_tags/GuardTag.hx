package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.action.events.pool.ActionPoolEvent;
import pw.tales.system.action_attack.AttackAction;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

/**
 *   Guard weapon tag.
 *
 *   @see <https://tales.pw/page/guard_(weapon_tag)>
**/
@autoregister
class GuardTag extends WeaponTag {
    public static final DN = "guard_(weapon_tag)";
    public static final TYPE:TraitType<GuardTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionPoolEvent, this.applyBonus);
    }

    public function applyBonus(e:ActionPoolEvent) {
        var action = e.getAction();
        var pool = e.getActionPool();
        var request = pool.getRequest();

        if (!Std.isOfType(action, AttackAction)) return;
        if (!this.isHolderPool(pool)) return;
        if (!this.isActionWithWeapon(action)) return;

        request.addModifier(1, this.getDN());
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<GuardTag>):GuardTag {
        return new GuardTag(gameObject);
    }
}
