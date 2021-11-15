package pw.tales.cofdsystem.weapon.traits;

import pw.tales.cofdsystem.action_attack.events.AttackSuccesesEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("DamageMod")
class DamageMod extends WeaponMod
{
    public static final DN = "Свойство:Damage";
    public static final TYPE = TraitType.createType(DN, DamageMod.new);

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(AttackSuccesesEvent, this.applyDamage);
    }

    public function applyDamage(event:AttackSuccesesEvent):Void
    {
        var action = event.getAction();

        if (this.isHolderAttack(action))
            return;

        event.setDamageSucceses(event.getDamageSucceses() + this.getValue());
    }
}
