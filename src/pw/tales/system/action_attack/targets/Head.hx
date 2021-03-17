package pw.tales.system.action_attack.targets;

import pw.tales.system.character.traits.advantages.SizeAdvantage;
import pw.tales.system.character.traits.tilts.stunned.StunnedTilt;

class Head implements ITarget {
    public static final instance = new Head();

    public function new() {}

    public function getDN():String {
        return "head";
    }

    public function getAttackModifer():Int {
        return -3;
    }

    public function apply(action:AttackAction):Void {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        var gameObject = action.getOpposition().getTargetPool().getGameObject();
        var size:SizeAdvantage = gameObject.getTraitManager().getTrait(SizeAdvantage.TYPE);

        if (totalDamage > size.getValue()) {
            var gameObject = action.getOpposition().getTargetPool().getGameObject();
            gameObject.getTraitManager().addTrait(StunnedTilt.TYPE);
        }
    }
}
