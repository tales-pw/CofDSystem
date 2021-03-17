package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action_attack.AttackAction;
import pw.tales.system.dices.EnumExplode;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

/**
 *   9-Again weapon tag.
 *
 *   @see <https://tales.pw/page/9-again_(weapon_tag)>
**/
class NineAgainTag extends WeaponTag {
    public static final DN = "9-again_(weapon_tag)";
    public static final TYPE = TraitType.createType(DN, create);

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

        e.getActionPool().getRequest().setExplode(EnumExplode.NINE_AGAIN);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<NineAgainTag>):NineAgainTag {
        return new NineAgainTag(gameObject);
    }
}
