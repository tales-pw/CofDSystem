package pw.tales.cofdsystem.armor.traits;

import pw.tales.cofdsystem.character.traits.advantages.DefenceAdvantage;
import pw.tales.cofdsystem.equipment.traits.EquipmentMod;
import pw.tales.cofdsystem.game_object.events.AdvantageModEvent;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class DefenceModifer extends EquipmentMod
{
    public static final DN = "Свойство:Defense";
    public static final TYPE:TraitType<DefenceModifer> = cast TraitType.createType(DN, create);

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(AdvantageModEvent, this.applyMod);
    }

    private function applyMod(event:AdvantageModEvent)
    {
        if (event.getAdvantage().getType() != DefenceAdvantage.TYPE)
            return;
        event.apply(this.value);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<DefenceModifer>):DefenceModifer
    {
        return new DefenceModifer(gameObject);
    }
}
