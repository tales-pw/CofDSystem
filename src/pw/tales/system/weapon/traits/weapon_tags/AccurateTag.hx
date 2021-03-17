package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action_attack.AttackAction;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

/**
 *   Accurate weapon tag.
 *   
 *   @see <https://tales.pw/page/accurate_(weapon_tag)>
**/
class AccurateTag extends WeaponTag {
    public static final DN = "accurate_(weapon_tag)";
    public static final TYPE:TraitType<AccurateTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionBuildPoolEvent, this.applyBonus);
    }

    public function applyBonus(e:ActionBuildPoolEvent) {
        var action = e.getAction();
        var pool = e.getActionPool();

        if (!Std.isOfType(action, AttackAction)) return;
        if (!this.isHolderPool(pool)) return;
        if (!this.doesHolderAct(action)) return;
        if (!this.isActionWithWeapon(action)) return;

        pool.getRequest().addModifier(1, DN);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<AccurateTag>):AccurateTag {
        return new AccurateTag(gameObject);
    }
}
