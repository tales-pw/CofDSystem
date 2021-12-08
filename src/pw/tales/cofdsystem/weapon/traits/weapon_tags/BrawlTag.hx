package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.utils.events.HandlerPriority;
import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.Utility;

/**
 *    Brawl weapon tag.
 *
 *    @see <https://tales.pw/page/brawl_(weapon_tag)>
**/
@RegisterTraitTypes
@:expose("BrawlTag")
class BrawlTag extends WeaponTag
{
    public static final DN = "brawl_(weapon_tag)";
    public static final TYPE = cast TraitType.createType(DN, BrawlTag.new);

    public static final PRIORITY = HandlerPriority.lower([WeaponTrait.PRIORITY]);

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<BrawlTag>
    )
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(
            ActionBuildPoolEvent,
            this.changeTraits,
            PRIORITY
        );
    }

    public function changeTraits(e:ActionBuildPoolEvent):Void
    {
        var action = e.getAction();
        var pool = e.getActionPool();

        // Is this holder's pool event.
        if (!this.isHolderPool(pool))
            return;

        // Is this holder's attack action.
        if (!this.isHolderAttack(action))
            return;

        var oldTraits = pool.getRequest().getTraits();
        var newTraits = Utility.replace(
            oldTraits,
            Skills.WEAPONRY.getDN(),
            Skills.BRAWL.getDN()
        );

        pool.getRequest().setTraits(newTraits);
    }
}
