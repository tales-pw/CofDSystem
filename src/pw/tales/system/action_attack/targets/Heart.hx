package pw.tales.system.action_attack.targets;

import pw.tales.system.action_attack.events.HeartPiercedEvent;
class Heart implements ITarget {
    public static final instance = new Heart();

    public function new() {}

    public function getDN():String {
        return "heart";
    }

    public function getAttackModifer():Int {
        return -3;
    }

    public function apply(action:AttackAction):Void {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        if (totalDamage >= 5) {
            var gameObject = action.getOpposition().getTargetPool().getGameObject();
            gameObject.getSystem().events.post(new HeartPiercedEvent(gameObject));
        }
    }
}