package pw.tales.cofdsystem.armor.traits.armor_rating;

import pw.tales.cofdsystem.weapon_ranged.traits.RangedWeapon;
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
    public static final TYPE = TraitType.createType(DN, ArmorRating.new);

    @Serialize("general")
    private var general:Int = 0;

    @Serialize("ballistic")
    private var ballistic:Int = 0;

    public function new(dn:String, gameObject:GameObject, type:TraitType<Dynamic>)
    {
        super(dn, gameObject, type);
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

    private function isRangedWeaponAttack(action:AttackAction):Bool
    {
        var weapon = action.getWeapon();

        if (weapon == null)
        {
            return false;
        }

        var gameObject = weapon.getGameObject();

        return gameObject.getTrait(RangedWeapon.TYPE) != null;
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

        if (!this.isRangedWeaponAttack(action))
        {
            ballistic = 0;
        }

        var armorGetEvent = new AttackArmorGetEvent(action, general, ballistic);
        system.events.post(armorGetEvent);

        general = armorGetEvent.getGeneral();
        ballistic = armorGetEvent.getBallistic();

        // Absorb damage
        var damage = DamageUtil.INSTANCE.simpleAbsorb(general, ballistic, event.getDamage());
        event.setDamage(damage);
    }
}
