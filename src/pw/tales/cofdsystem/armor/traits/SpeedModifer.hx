package pw.tales.cofdsystem.armor.traits;

import pw.tales.cofdsystem.character.traits.advantages.SpeedAdvantage;
import pw.tales.cofdsystem.equipment.traits.EquipmentMod;
import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class SpeedModifer extends EquipmentMod
{
    public static final DN = "Свойство:Speed";
    public static final TYPE:TraitType<SpeedModifer> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(AdvantageModEvent, this.applyMod);
    }

    private function applyMod(event:AdvantageModEvent)
    {
        if (event.getAdvantage().getType() != SpeedAdvantage.TYPE)
            return;
        event.apply(this.value);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<SpeedModifer>):SpeedModifer
    {
        return new SpeedModifer(gameObject);
    }
}
