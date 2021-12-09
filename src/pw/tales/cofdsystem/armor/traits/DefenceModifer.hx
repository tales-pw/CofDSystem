package pw.tales.cofdsystem.armor.traits;

import pw.tales.cofdsystem.utils.events.IEvent;
import pw.tales.cofdsystem.game_object.events.TraitModEvent;
import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.equipment.traits.EquipmentMod;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("DefenceModifer")
class DefenceModifer extends EquipmentMod
{
    public static final DN = "Свойство:Defense";
    public static final TYPE = TraitType.createType(DN, DefenceModifer.new);

    public function new(
        dn:String,
        gameObject:GameObject,
        type:TraitType<Dynamic>
    )
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(TraitModEvent, this.applyMod);
    }

    private function applyMod(event:TraitModEvent):Void
    {
        if (event.getTrait().getType() != DefenceAdvantage.TYPE)
            return;
        event.apply(this.value);
    }

    public override function shouldUpdateView(event:IEvent):Bool
    {
        return true;
    }
}
