package pw.tales.cofdsystem.weapon_ranged.traits;

import pw.tales.cofdsystem.utils.Utility;
import pw.tales.cofdsystem.weapon_ranged.events.RangedWeaponDefenceEvent;
import pw.tales.cofdsystem.action.events.pool.ActionBuildPoolEvent;
import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.skill.Skills;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;
import pw.tales.cofdsystem.weapon.traits.WeaponTrait;

@RegisterTraitTypes
@:expose("RangedWeapon")
class RangedWeapon extends WeaponTrait
{
    public static final DN = "ranged_weapon";
    public static final TYPE = TraitType.createType(DN, RangedWeapon.new);

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

    private function canApplyDefence(gameObject:GameObject):Bool
    {
        var event = new RangedWeaponDefenceEvent(gameObject);
        this.gameObject.getSystem().events.post(event);
        return event.getCanApply();
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

        var attack = cast Utility.downcast(action, AttackAction);
        var competition = attack.getCompetition();

        competition.getActorPool().getRequest().setTraits([
            Attributes.DEXTERITY.getDN(),
            Skills.SHOOTING.getDN()
        ]);

        var targetPool = competition.getTargetPool();
        if (!canApplyDefence(targetPool.getGameObject()))
        {
            targetPool.getRequest().setTraits([]);
        }
    }
}
