package pw.tales.cofdsystem.action_attack.targets;

import pw.tales.cofdsystem.character.traits.tilts.ArmWrackTilt;

@:expose("Hand")
class Hand implements ITarget
{
    public static final INSTANCE = new Hand();

    public function new() {}

    public function getDN():String
    {
        return "hand";
    }

    public function getAttackModifer():Int
    {
        return -4;
    }

    public function apply(action:AttackAction):Void
    {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        if (totalDamage > 0)
        {
            var gameObject = action.getCompetition().getTarget();
            gameObject.getTraitManager().addTrait(ArmWrackTilt.TYPE);
        }
    }
}
