package pw.tales.cofdsystem.action_attack.targets;

import pw.tales.cofdsystem.character.traits.attribute.Attributes;
import pw.tales.cofdsystem.character.traits.tilts.ArmWrackTilt;

@:expose("Arm")
class Arm implements ITarget
{
    public static final INSTANCE = new Arm();

    public function new() {}

    public function getDN():String
    {
        return "arm";
    }

    public function getAttackModifer():Int
    {
        return -2;
    }

    public function apply(action:AttackAction):Void
    {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        var gameObject = action.getCompetition().getTarget();
        var stamina = gameObject.getTrait(Attributes.STAMINA);

        if (totalDamage > stamina.getValue())
        {
            gameObject.getTraitManager().addTrait(ArmWrackTilt.TYPE);
        }
    }
}
