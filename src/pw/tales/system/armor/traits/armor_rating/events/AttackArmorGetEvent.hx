package pw.tales.system.armor.traits.armor_rating.events;

import pw.tales.system.action_attack.AttackAction;
import pw.tales.system.action_attack.events.AttackEvent;

class AttackArmorGetEvent extends AttackEvent {
    private var general:Int;
    private var ballistic:Int;

    public function new(system:CofDSystem, action:AttackAction, general:Int, ballistic:Int) {
        super(action, system);
        this.general = general;
        this.ballistic = ballistic;
    }

    public function getGeneral():Int {
        return this.general;
    }

    public function getBallistic():Int {
        return this.ballistic;
    }

    public function setGeneral(general:Int) {
        this.general = general;
    }

    public function setBallistic(ballistic:Int) {
        this.ballistic = ballistic;
    }
}
