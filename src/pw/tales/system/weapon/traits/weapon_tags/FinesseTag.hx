package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action_attack.AttackAction;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.Utility;

/**
 *   Finesse weapon tag.
 *
 *   @see <https://tales.pw/page/finesse_(weapon_tag)>
**/
@autoregister
class FinesseTag extends WeaponTag {
    public static final DN = "finesse_(weapon_tag)";
    public static final TYPE:TraitType<FinesseTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionBuildPoolEvent, this.replaceStrWithDex);
    }

    public function replaceStrWithDex(e:ActionBuildPoolEvent) {
        var action = e.getAction();
        var pool = e.getActionPool();

        if (!Std.isOfType(action, AttackAction)) return;
        if (!this.isHolderPool(pool)) return;
        if (!this.doesHolderAct(action)) return;
        if (!this.isActionWithWeapon(action)) return;

        var oldTraits = pool.getRequest().getTraits();
        var newTraits = Utility.replace(
            oldTraits,
            Attributes.STRENGTH.getDN(),
            Attributes.DEXTERITY.getDN()
        );

        pool.getRequest().setTraits(newTraits);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<FinesseTag>):FinesseTag {
        return new FinesseTag(gameObject);
    }
}
