package pw.tales.cofdsystem.armor.traits.armor_rating;

import pw.tales.cofdsystem.action.Action;
import pw.tales.cofdsystem.character.traits.HeldWeapon;
import pw.tales.cofdsystem.action_attack.AttackAction;
import pw.tales.cofdsystem.action_attack.events.AttackDamageGetEvent;
import pw.tales.cofdsystem.armor.traits.armor_rating.events.AttackArmorGetEvent;
import pw.tales.cofdsystem.damage.DamageUtil;
import pw.tales.cofdsystem.equipment.traits.EquipmentTrait;
import pw.tales.cofdsystem.game_object.GameObject;
import pw.tales.cofdsystem.game_object.traits.TraitType;

@RegisterTraitTypes
class ArmorRating extends EquipmentTrait
{
    public static final DN = "Свойство:Rating";
    public static final TYPE:TraitType<ArmorRating> = cast TraitType.createType(DN, create);

    @Serialize("general")
    private var general:Int = 0;

    @Serialize("ballistic")
    private var ballistic:Int = 0;

    public function new(gameObject:GameObject)
    {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(AttackDamageGetEvent, this.applyArmorAbsorption);
    }

    public function setGeneral(general:Int):Void
    {
        this.general = general;
        this.notifyUpdated();
    }

    public function setBallistic(ballistic:Int):Void
    {
        this.ballistic = ballistic;
        this.notifyUpdated();
    }

    public function getGeneral():Int
    {
        return this.general;
    }

    public function getBallistic():Int
    {
        return this.ballistic;
    }

    private function applyArmorAbsorption(event:AttackDamageGetEvent):Void
    {
        var holder = this.getHolder();

        if (holder == null)
            return;

        if (!event.isTarget(holder))
            return;

        // Post armor get event
        var action = event.getAction();
        var system = action.getSystem();

        var general = this.getGeneral();
        var ballistic = this.getBallistic();

        var armorGetEvent = new AttackArmorGetEvent(action, general, ballistic);
        system.events.post(armorGetEvent);

        general = armorGetEvent.getGeneral();
        ballistic = armorGetEvent.getBallistic();

        // Absorb damage
        var damage = DamageUtil.INSTANCE.simpleAbsorb(general, ballistic, event.getDamage());
        event.setDamage(damage);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<ArmorRating>):ArmorRating
    {
        return new ArmorRating(gameObject);
    }
}
