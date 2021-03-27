package pw.tales.system.weapon.traits.weapon_tags;

import pw.tales.system.action.events.pool.ActionBuildPoolEvent;
import pw.tales.system.action_attack.AttackAction;
import pw.tales.system.character.traits.skill.Skills;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;
import pw.tales.system.utils.Utility;

/**
*    Brawl weapon tag.
*
*    @see <https://tales.pw/page/brawl_(weapon_tag)>
**/
@autoregister
class BrawlTag extends WeaponTag {
    public static final DN = "brawl_(weapon_tag)";
    public static final TYPE:TraitType<BrawlTag> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionBuildPoolEvent, this.changeTraits);
    }

    public function changeTraits(e:ActionBuildPoolEvent) {
        var action = e.getAction();
        var pool = e.getActionPool();

        if (!Std.isOfType(action, AttackAction)) return;
        if (!this.isHolderPool(pool)) return;
        if (!this.doesHolderAct(action)) return;
        if (!this.isActionWithWeapon(action)) return;

        var oldTraits = pool.getRequest().getTraits();
        var newTraits = Utility.replace(oldTraits, Skills.WEAPONRY.getDN(), Skills.BRAWL.getDN());

        pool.getRequest().setTraits(newTraits);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<BrawlTag>):BrawlTag {
        return new BrawlTag(gameObject);
    }
}
