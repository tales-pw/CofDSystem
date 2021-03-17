package pw.tales.system.action_attack.targets;

import pw.tales.system.character.traits.tilts.arm_wrack.ArmWrackTilt;
class Hand implements ITarget {
    public static final instance = new Hand();

    public function new() {}

    public function getDN():String {
        return "hand";
    }

    public function getAttackModifer():Int {
        return -4;
    }

    public function apply(action:AttackAction):Void {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        if (totalDamage > 0) {
            var gameObject = action.getOpposition().getTargetPool().getGameObject();
            gameObject.getTraitManager().addTrait(ArmWrackTilt.TYPE);
        }
    }
}