package pw.tales.cofdsystem.weapon.traits.weapon_tags;

import pw.tales.cofdsystem.utils.events.HandlerPriority;
import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.utils.Utility;

/**
 *   Finesse weapon tag.
 *
 *   @see <https://tales.pw/page/finesse_(weapon_tag)>
**/
@RegisterTraitTypes
class FinesseTag extends WeaponTag
{
    public static final DN = "finesse_(weapon_tag)";
    public static final TYPE:TraitType<FinesseTag> = cast TraitType.createType(DN, create);

    public static final PRIORITY = HandlerPriority.lower([WeaponTrait.PRIORITY]);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionBuildPoolEvent, this.replaceStrWithDex, PRIORITY);
    }

    public function replaceStrWithDex(event:ActionBuildPoolEvent):Void
    {
        var action = event.getAction();
        var pool = event.getActionPool();

        // Is this holder's pool event.
        if (!this.isHolderPool(pool))
            return;

        // Is this holder's attack action.
        if (!this.isHolderAttack(action))
            return;

        var oldTraits = pool.getRequest().getTraits();
        var newTraits = Utility.replace(oldTraits, Attributes.STRENGTH.getDN(), Attributes.DEXTERITY.getDN());

        pool.getRequest().setTraits(newTraits);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<FinesseTag>):FinesseTag
    {
        return new FinesseTag(gameObject);
    }
}
