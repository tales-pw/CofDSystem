package pw.tales.system.armor.traits.armor_rating;

import pw.tales.system.action_attack.events.AttackDamageGetEvent;
import pw.tales.system.armor.traits.armor_rating.events.AttackArmorGetEvent;
import pw.tales.system.damage.DamageUtil;
import pw.tales.system.equipment.traits.EquipmentTrait;
import pw.tales.system.game_object.GameObject;
import pw.tales.system.game_object.traits.TraitType;

class ArmorRating extends EquipmentTrait {
    public static final DN = "Свойство:Rating";
    public static final TYPE = TraitType.createType(DN, create);

    @Serialize("general")
    private var general:Int = 0;

    @Serialize("ballistic")
    private var ballistic:Int = 0;

    public function new(gameObject:GameObject) {
        super(DN, gameObject, TYPE);
        this.holderEventBus.addHandler(AttackDamageGetEvent, this.applyArmorAbsorption);
    }

    public function setGeneral(general:Int) {
        this.general = general;
        this.notifyUpdated();
    }

    public function setBallistic(ballistic:Int) {
        this.ballistic = ballistic;
        this.notifyUpdated();
    }

    public function getGeneral():Int {
        return this.general;
    }

    public function getBallistic():Int {
        return this.ballistic;
    }

    private function applyArmorAbsorption(event:AttackDamageGetEvent) {
        var holder = this.getHolder();

        if (holder == null) return;
        if (!event.isTarget(holder)) return;

        // Post armor get event
        var system = event.getSystem();
        var action = event.getAction();

        var armorGetEvent = new AttackArmorGetEvent(system, action, this.getGeneral(), this.getBallistic());
        event.getSystem().events.post(armorGetEvent);

        var general = armorGetEvent.getGeneral();
        var ballistic = armorGetEvent.getBallistic();

        // Absorb damage
        var damage = DamageUtil.INSTANCE.simpleAbsorb(general, ballistic, event.getDamage());
        event.setDamage(damage);
    }

    public static function create(dn:String, gameObject:GameObject, t:TraitType<ArmorRating>):ArmorRating {
        return new ArmorRating(gameObject);
    }
}
