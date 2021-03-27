package pw.tales.system.armor.traits;

import pw.tales.system.character.traits.advantages.SpeedAdvantage;
import pw.tales.system.equipment.traits.EquipmentMod;
import pw.tales.system.game_object.events.AdvantageModEvent;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

@autoregister
class SpeedModifer extends EquipmentMod {
    public static final DN = "Свойство:Speed";
    public static final TYPE:TraitType<SpeedModifer> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(AdvantageModEvent, this.applyMod);
    }

    private function applyMod(event:AdvantageModEvent) {
        if (event.getAdvantage().getType() != SpeedAdvantage.TYPE) return;
        event.apply(this.value);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<SpeedModifer>):SpeedModifer {
        return new SpeedModifer(gameObject);
    }
}
