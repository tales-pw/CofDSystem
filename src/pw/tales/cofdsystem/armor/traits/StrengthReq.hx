package pw.tales.cofdsystem.armor.traits;

import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.character.traits.attribute.Attribute;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.equipment.traits.EquipmentMod;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class StrengthReq extends EquipmentMod
{
    public static final DN = "Свойство:Strength_Requirements";
    public static final TYPE:TraitType<StrengthReq> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(ActionPoolEvent, this.applyMod);
    }

    private function applyMod(event:ActionPoolEvent)
    {
        var holder = this.getHolder();
        var action = event.getAction();

        if (holder == null)
            return;
        if (!event.isPoolOwner(holder))
            return;
        if (!Std.isOfType(action, AttackAction))
            return;

        var strengthTrait = holder.getTrait(Attributes.STRENGTH);
        if (strengthTrait == null)
            return;

        var strength = strengthTrait.getValue();
        var mod = 3 * Std.int(Math.min(strength - this.getValue(), 0));

        if (mod != 0)
        {
            var request = event.getActionPool().getRequest();
            request.addModifier(mod, StrengthReq.DN);
            request.addIgnoreLimit(StrengthReq.DN);
        }
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<StrengthReq>):StrengthReq
    {
        return new StrengthReq(gameObject);
    }
}
