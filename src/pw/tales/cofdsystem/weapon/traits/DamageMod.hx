package pw.tales.cofdsystem.weapon.traits;

import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.action_attack.events.AttackSuccesesEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class DamageMod extends WeaponMod
{
    public static final DN = "Свойство:Damage";
    public static final TYPE:TraitType<DamageMod> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(AttackSuccesesEvent, this.applyDamage);
    }

    public function applyDamage(event:AttackSuccesesEvent)
    {
        var action = event.getAction();

        if (!Std.isOfType(action, AttackAction))
            return;
        if (!this.doesHolderAct(action))
            return;
        if (!this.isActionWithWeapon(action))
            return;

        event.setDamageSucceses(event.getDamageSucceses() + this.getValue());
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<DamageMod>):DamageMod
    {
        return new DamageMod(gameObject);
    }
}
