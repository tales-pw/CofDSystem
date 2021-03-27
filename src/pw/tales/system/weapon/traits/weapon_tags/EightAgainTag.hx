package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action_attack.AttackAction;
import pw.tales.system.dices.EnumExplode;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

/**
 *   8-Again weapon tag.
 *
 *   @see <https://tales.pw/page/8-again_(weapon_tag)>
**/
@autoregister
class EightAgainTag extends WeaponTag {
    public static final DN = "8-again_(weapon_tag)";
    public static final TYPE:TraitType<EightAgainTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionBuildPoolEvent, this.applyExplode);
    }

    public function applyExplode(e:ActionBuildPoolEvent) {
        var action = e.getAction();
        var pool = e.getActionPool();

        if (!Std.isOfType(action, AttackAction)) return;
        if (!this.isHolderPool(pool)) return;
        if (!this.doesHolderAct(action)) return;
        if (!this.isActionWithWeapon(action)) return;

        pool.getRequest().setExplode(EnumExplode.EIGHT_AGAIN);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<EightAgainTag>):EightAgainTag {
        return new EightAgainTag(gameObject);
    }
}
