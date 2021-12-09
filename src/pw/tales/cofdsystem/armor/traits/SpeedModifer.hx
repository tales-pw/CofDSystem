package pw.tales.cofdsystem.armor.traits;

import pw.tales.cofdsystem.utils.events.IEvent;
import pw.tales.cofdsystem.game_object.events.TraitModEvent;
import pw.tales.cofdsystem.character.traits.advantages.SpeedAdvantage;
import pw.tales.cofdsystem.equipment.traits.EquipmentMod;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("SpeedModifer")
class SpeedModifer extends EquipmentMod
{
    public static final DN = "Свойство:Speed";
    public static final TYPE = TraitType.createType(DN, SpeedModifer.new);

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
        if (event.getTrait().getType() != SpeedAdvantage.TYPE)
            return;

        event.apply(this.value);
    }

    public override function shouldUpdateView(event:IEvent):Bool
    {
        return true;
    }
}
