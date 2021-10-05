package pw.tales.cofdsystem.action_attack.targets;

import pw.tales.cofdsystem.character.traits.advantages.SizeAdvantage;
import pw.tales.cofdsystem.character.traits.tilts.stunned.StunnedTilt;

class Head implements ITarget
{
    public static final instance = new Head();

    public function new() {}

    public function getDN():String
    {
        return "head";
    }

    public function getAttackModifer():Int
    {
        return -3;
    }

    public function apply(action:AttackAction):Void
    {
        var damage = action.getDamage();
        var totalDamage = damage.getBashing() + damage.getLethal() + damage.getAggravated();

        var gameObject = action.getCompetition().getTarget();
        var size:SizeAdvantage = gameObject.getTrait(SizeAdvantage.TYPE);

        if (totalDamage > 0)
        {
            gameObject.getTraitManager().addTrait(StunnedTilt.TYPE);
        }
    }
}
