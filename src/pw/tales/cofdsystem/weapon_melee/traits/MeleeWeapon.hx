package pw.tales.cofdsystem.weapon_melee.traits;

import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.traits.WeaponTrait;

@RegisterTraitTypes
@:expose("MeleeWeapon")
class MeleeWeapon extends WeaponTrait
{
    public static final DN = "melee_weapon";
    public static final TYPE = cast TraitType.createType(DN, MeleeWeapon.new);

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(
            ActionBuildPoolEvent,
            this.changeTraits,
            WeaponTrait.PRIORITY
        );
    }

    public function changeTraits(event:ActionPoolEvent):Void
    {
        var action = event.getAction();
        var pool = event.getActionPool();

        // Is this holder's pool event.
        if (!this.isHolderPool(pool))
            return;

        // Is this holder's attack action.
        if (!this.isHolderAttack(action))
            return;

        event.getActionPool().getRequest().setTraits([
            Attributes.STRENGTH.getDN(),
            Skills.WEAPONRY.getDN()
        ]);
    }
}
