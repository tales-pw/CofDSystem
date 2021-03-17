package pw.tales.system.action_attack.targets;

import pw.tales.system.character.traits.attribute.Attribute;
import pw.tales.system.character.traits.attribute.Attributes;
import pw.tales.system.character.traits.tilts.leg_wrack.LegWrackTilt;

class Leg implements ITarget {
    public static final instance = new Leg();

    public function new() {}

    public function getDN():String {
        return "leg";
    }

    public function getAttackModifer():Int {
        return -2;
    }

    public function apply(action:AttackAction):Void {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        var gameObject = action.getOpposition().getTargetPool().getGameObject();
        var stamina:Attribute = gameObject.getTraitManager().getTrait(Attributes.STAMINA);

        if (totalDamage > stamina.getValue()) {
            var gameObject = action.getOpposition().getTargetPool().getGameObject();
            gameObject.getTraitManager().addTrait(LegWrackTilt.TYPE);
        }
    }
}
