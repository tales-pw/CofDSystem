package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

/**
 *   Reach weapon tag.
 *
 *   @see <https://tales.pw/page/reach_(weapon_tag)>
**/
@RegisterTraitTypes
class ReachTag extends WeaponTag {
    public static final DN = "reach_(weapon_tag)";
    public static final TYPE:TraitType<ReachTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionPoolEvent, this.applyBonuses);
    }

    public function applyBonuses(e:ActionPoolEvent) {
        var action = e.getAction();
        var pool = e.getActionPool();

        if (!Std.isOfType(action, AttackAction)) return;
        if (!this.isHolderPool(pool)) return;
        if (!this.isActionWithWeapon(action)) return;
        if (!pool.hasTrait(DefenceAdvantage.TYPE.getDN())) return;

        pool.getRequest().addModifier(1, DN);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<ReachTag>):ReachTag {
        return new ReachTag(gameObject);
    }
}
