package pw.tales.cofdsystem.armor.traits;

import pw.tales.cofdsystem.character.traits.advantages.SpeedAdvantage;
import pw.tales.cofdsystem.equipment.traits.EquipmentMod;
import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
@:expose("SpeedModifer")
class SpeedModifer extends EquipmentMod
{
    public static final DN = "Свойство:Speed";
    public static final TYPE = TraitType.createType(DN, SpeedModifer.new);

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
        this.holderEventBus.addHandler(AdvantageModEvent, this.applyMod);
    }

    private function applyMod(event:AdvantageModEvent):Void
    {
        if (event.getAdvantage().getType() != SpeedAdvantage.TYPE)
            return;
        event.apply(this.value);
    }
}
