package pw.tales.cofdsystem.weapon.traits;

import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.action_attack.events.AttackDamageGetTypeEvent;
import pw.tales.cofdsystem.damage.DamageType;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class LethalDamage extends WeaponTrait
{
    public static final DN = "lethal_damage";
    public static final TYPE:TraitType<LethalDamage> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(AttackDamageGetTypeEvent, this.makeLethal);
    }

    private function makeLethal(event:AttackDamageGetTypeEvent)
    {
        var action = event.getAction();

        if (!Std.isOfType(action, AttackAction))
            return;
        if (!this.doesHolderAct(action))
            return;
        if (!this.isActionWithWeapon(action))
            return;

        event.setDamageType(DamageType.LETHAL);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<LethalDamage>):LethalDamage
    {
        return new LethalDamage(gameObject);
    }
}
