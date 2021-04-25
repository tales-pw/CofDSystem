package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.dices.EnumExplode;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   9-Again weapon tag.
 *
 *   @see <https://tales.pw/page/9-again_(weapon_tag)>
**/
@RegisterTraitTypes
class NineAgainTag extends WeaponTag {
    public static final DN = "9-again_(weapon_tag)";
    public static final TYPE:TraitType<NineAgainTag> = cast TraitType.createType(DN, create);

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
