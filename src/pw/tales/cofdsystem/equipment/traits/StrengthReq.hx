package pw.tales.cofdsystem.equipment.traits;

import pw.tales.cofdsystem.equipment.events.StrengthReqEvent;
import pw.tales.cofdsystem.action.events.pool.ActionPoolEvent;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class StrengthReq extends EquipmentMod
{
    public static final DN = "Свойство:Strength_Requirements";
    public static final TYPE:TraitType<StrengthReq> = TraitType.createType(DN, StrengthReq.new);

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(ActionPoolEvent, this.applyMod);
    }

    private function getModifiedValue():Int
    {
        var event = new StrengthReqEvent(this.gameObject, this.value);
        this.eventBus.post(event);
        return event.getValue();
    }

    private function applyMod(event:ActionPoolEvent):Void
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

        var value = this.getModifiedValue();
        var strength = strengthTrait.getValue();
        var mod = 3 * Std.int(Math.min(strength - value, 0));

        if (mod != 0)
        {
            var request = event.getActionPool().getRequest();
            request.addModifier(mod, StrengthReq.DN);
            request.addIgnoreLimit(StrengthReq.DN);
        }
    }
}
