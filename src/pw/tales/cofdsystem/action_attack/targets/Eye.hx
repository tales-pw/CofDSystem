package pw.tales.cofdsystem.action_attack.targets;

import pw.tales.cofdsystem.character.traits.tilts.blinded.BlindedTilt;

class Eye implements ITarget {
    public static final instance = new Eye();

    public function new() {}

    public function getDN():String {
        return "eye";
    }

    public function getAttackModifer():Int {
        return -5;
    }

    public function apply(action:AttackAction):Void {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        if (totalDamage > 0) {
            var gameObject = action.getOpposition().getTargetPool().getGameObject();
            gameObject.getTraitManager().addTrait(BlindedTilt.TYPE);
        }
    }
}