package pw.tales.cofdsystem.weapon.traits;

import pw.tales.cofdsystem.action_attack.events.AttackDamageGetTypeEvent;
import pw.tales.cofdsystem.damage.DamageType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class LethalDamage extends WeaponTrait
{
    public static final DN = "lethal_damage";
    public static final TYPE = TraitType.createType(DN, LethalDamage.new);

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(AttackDamageGetTypeEvent, this.makeLethal);
    }

    private function makeLethal(event:AttackDamageGetTypeEvent):Void
    {
        var action = event.getAction();

        if (!this.isHolderAttack(action))
            return;

        event.setDamageType(DamageType.LETHAL);
    }
}
